Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC54CCC0B
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 03:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiCDDAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 22:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiCDDAf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 22:00:35 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A9A17EDAA
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 18:59:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V6ACTqx_1646362783;
Received: from 30.43.105.151(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V6ACTqx_1646362783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Mar 2022 10:59:45 +0800
Message-ID: <8f150750-cb59-496b-d676-b4bb52741d21@linux.alibaba.com>
Date:   Fri, 4 Mar 2022 10:59:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v3 09/12] RDMA/erdma: Add connection management
 (CM) support
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Cheng Xu <chengyou.xc@alibaba-inc.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB26319912BAFA6ACB1539A8FC99049@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB26319912BAFA6ACB1539A8FC99049@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/4/22 2:21 AM, Bernard Metzler wrote:

<...>

>> +static int erdma_send_mpareqrep(struct erdma_cep *cep, const void *pdata,
>> +				u8 pd_len)
>> +{
>> +	struct socket *s = cep->sock;
>> +	struct mpa_rr *rr = &cep->mpa.hdr;
>> +	struct kvec iov[3];
>> +	struct msghdr msg;
>> +	int iovec_num = 0;
>> +	int ret;
>> +	int mpa_len;
>> +
>> +	memset(&msg, 0, sizeof(msg));
>> +
>> +	rr->params.pd_len = cpu_to_be16(pd_len);
>> +
>> +	iov[iovec_num].iov_base = rr;
>> +	iov[iovec_num].iov_len = sizeof(*rr);
>> +	iovec_num++;
>> +	mpa_len = sizeof(*rr);
>> +
>> +	iov[iovec_num].iov_base = &cep->mpa.ext_data;
>> +	iov[iovec_num].iov_len = sizeof(cep->mpa.ext_data);
>> +	iovec_num++;
>> +	mpa_len += sizeof(cep->mpa.ext_data);
>> +
>> +	if (pd_len) {
>> +		iov[iovec_num].iov_base = (char *)pdata;
>> +		iov[iovec_num].iov_len = pd_len;
>> +		mpa_len += pd_len;
>> +		iovec_num++;
>> +	}
>> +
>> +	ret = kernel_sendmsg(s, &msg, iov, iovec_num + 1, mpa_len);
> 
> 
> Before kernel_sendmsg(), iovec_num already reflects the
> right number of iov elements, so don't add 1 here.
> 
> Did you ever test with private data?? iovec_num + 1 would be
> at 4, which points behind iov[]. Maybe the correct mpa_len
> parameter saved you.
> 

Yeah, this is a bug. I tested it before, and re-run our testcase for
this again, it's passed just now. I check cp_sendmsg_locked function,
It seems that the 'mpa_len' limits the sendmsg range as you said.

Thanks


>> +
>> +	return ret < 0 ? ret : 0;
>> +}
>> +

<...>

>> +	if (!to_rcv) {
>> +		/*
>> +		 * We have received the whole MPA Request/Reply message.
>> +		 * CHeck against peer protocol violation.
> 
> CHeck -> Check
> 

Will fix.

>> +		 */
>> +		u32 word;
>> +
>> +		ret = __recv_mpa_hdr(cep, 0, (char *)&word, sizeof(word),
>> +				     &rcvd);
>> +		if (ret == -EAGAIN && rcvd == 0)
>> +			return 0;
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		return -EPROTO;
>> +	}
> 
> without a few comments, this function is hard to understand.
> Maybe add a statement here that at this point private data are
> signaled and are now being received, or continued to be received?
> 
Will add it, and it's better with a comment here.


>> +
>> +	if (!cep->mpa.pdata) {
>> +		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>> +		if (!cep->mpa.pdata)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	rcvd = ksock_recv(s, cep->mpa.pdata + pd_rcvd, to_rcv + 4,
>> +			  MSG_DONTWAIT);
>> +	if (rcvd < 0)
>> +		return rcvd;
>> +
>> +	if (rcvd > to_rcv)
>> +		return -EPROTO;
>> +
>> +	cep->mpa.bytes_rcvd += rcvd;
>> +
>> +	if (to_rcv == rcvd)
>> +		return 0;
>> +
>> +	return -EAGAIN;
>> +}
>> +
>> +/*
>> + * erdma_proc_mpareq()
>> + *
>> + * Read MPA Request from socket and signal new connection to IWCM
>> + * if success. Caller must hold lock on corresponding listening CEP.
>> + */
>> +static int erdma_proc_mpareq(struct erdma_cep *cep)
>> +{
>> +	struct mpa_rr *req;
>> +	int ret;
>> +
>> +	ret = erdma_recv_mpa_rr(cep);
>> +	if (ret)
>> +		return ret;
>> +
>> +	req = &cep->mpa.hdr;
>> +
>> +	if (__mpa_rr_revision(req->params.bits) != MPA_REVISION_EXT_1)
> 
> This has already been checked in erdma_recv_mpa_rr()
> 

Yes, will remove it.

> 
>> +		return -EPROTO;
>> +
>> +	if (memcmp(req->key, MPA_KEY_REQ, MPA_KEY_SIZE))
>> +		return -EPROTO;
>> +
>> +	memcpy(req->key, MPA_KEY_REP, 16);
>> +
>> +	/* Currently does not support marker and crc. */
>> +	if (req->params.bits & MPA_RR_FLAG_MARKERS ||
>> +	    req->params.bits & MPA_RR_FLAG_CRC)
>> +		goto reject_conn;
>> +
>> +	cep->state = ERDMA_EPSTATE_RECVD_MPAREQ;
>> +
>> +	/* Keep reference until IWCM accepts/rejects */
>> +	erdma_cep_get(cep);
>> +	ret = erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REQUEST, 0);
>> +	if (ret)
>> +		erdma_cep_put(cep);
>> +
>> +	return ret;
>> +
>> +reject_conn:
>> +	req->params.bits &= ~MPA_RR_FLAG_MARKERS;
>> +	req->params.bits |= MPA_RR_FLAG_REJECT;
>> +	req->params.bits &= ~MPA_RR_FLAG_CRC;
>> +
>> +	kfree(cep->mpa.pdata);
>> +	cep->mpa.pdata = NULL;
>> +	erdma_send_mpareqrep(cep, NULL, 0);
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int erdma_proc_mpareply(struct erdma_cep *cep)
>> +{
>> +	struct erdma_qp_attrs qp_attrs;
>> +	struct erdma_qp *qp = cep->qp;
>> +	struct mpa_rr *rep;
>> +	int ret;
>> +
>> +	ret = erdma_recv_mpa_rr(cep);
>> +	if (ret != -EAGAIN)
>> +		erdma_cancel_mpatimer(cep);
>> +	if (ret)
>> +		goto out_err;
>> +
>> +	rep = &cep->mpa.hdr;
>> +
>> +	if (__mpa_rr_revision(rep->params.bits) != MPA_REVISION_EXT_1) {
> 
> This has already been checked in erdma_recv_mpa_rr()
> 

Also will remove it.

>> +		ret = -EPROTO;
>> +		goto out_err;
>> +	}
>> +	if (memcmp(rep->key, MPA_KEY_REP, MPA_KEY_SIZE)) {
>> +		ret = -EPROTO;
>> +		goto out_err;

<...>

>> +
>> +		if (ret && ret != -EAGAIN)
>> +			release_cep = 1;
>> +		break;
>> +	case ERDMA_CM_WORK_CLOSE_LLP:
>> +		if (cep->cm_id)
>> +			erdma_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
>> +		release_cep = 1;
>> +		break;
>> +	case ERDMA_CM_WORK_PEER_CLOSE:
>> +		if (cep->cm_id) {
>> +			if (cep->state == ERDMA_EPSTATE_CONNECTING ||
>> +			    cep->state == ERDMA_EPSTATE_AWAIT_MPAREP) {
>> +				/*
>> +				 * MPA reply not received, but connection drop
>> +				 */
>> +				erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
>> +						-ECONNRESET);
>> +			} else if (cep->state == ERDMA_EPSTATE_RDMA_MODE) {
>> +				/*
>> +				 * NOTE: IW_CM_EVENT_DISCONNECT is given just
>> +				 *       to transition IWCM into CLOSING.
>> +				 */
>> +				erdma_cm_upcall(cep, IW_CM_EVENT_DISCONNECT, 0);
>> +				erdma_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
>> +			}
>> +		} else if (cep->state == ERDMA_EPSTATE_AWAIT_MPAREQ) {
>> +			/* Socket close before MPA request received. */
>> +			erdma_disassoc_listen_cep(cep);
>> +			erdma_cep_put(cep);
>> +		}
>> +		release_cep = 1;
>> +		break;
>> +	case ERDMA_CM_WORK_MPATIMEOUT:
>> +		cep->mpa_timer = NULL;
>> +		if (cep->state == ERDMA_EPSTATE_AWAIT_MPAREP) {
>> +			/*
>> +			 * MPA request timed out:
>> +			 * Hide any partially received private data and signal
>> +			 * timeout
>> +			 */
>> +			cep->mpa.hdr.params.pd_len = 0;
>> +
>> +			if (cep->cm_id)
>> +				erdma_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
>> +						-ETIMEDOUT);
>> +			release_cep = 1;
>> +		} else if (cep->state == ERDMA_EPSTATE_AWAIT_MPAREQ) {
>> +			/* No MPA request received after peer TCP stream setup.
> 
> 
> exceeds 80 chars per line

Will fix. clang-format seems not format comment lines. I will check this
in all the .c/.h files.

Thanks,
Cheng Xu

