Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4065E99EE
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiIZG4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 02:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiIZG4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 02:56:09 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA523BEA
        for <linux-rdma@vger.kernel.org>; Sun, 25 Sep 2022 23:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664175366; i=@fujitsu.com;
        bh=UYeLWYDYYSqFGlkUeNuDMFcmgAtEiADLsgS/ARZUh3g=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=kOkl7XMt1pvEl1tjUYVIdsx96oSr0eFlWNg47QFuIKtIUZuSMqIhhWc5ly91Wk0lh
         B3PKIE8p5u5s7vFsY13xZEOJFeveRzex2PZaSko0ebO1PnkGbeoUkjRbzuTWkEfzNq
         xy04Iv7OeKsvwFYxEq7PCUywmpIPXq/0FTCiZopXGpKqE2eVPN3aIk1jGx7Xw80TUE
         u7+r37XqTo5J5NdvSNbRKN9oxeFT5BnJlpjbIIXMAScoM1HgIxZoVUA+ucTEDG8rlK
         VvmM0R2xEMkYEn7MdZoTWwiZ87QdFFWOQjUGL+roiQ+BdZk5mELV+dp6+yr7t++yjh
         Da5BMaE0g0AJA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRWlGSWpSXmKPExsViZ8ORpMvqa5h
  ssGSysMX+p89ZLK7828NoMeXXUmaLZ4d6WSy+TJ3GbHH+WD+7A5vHzll32T0W73nJ5LFpVSeb
  R2/zOzaPz5vkAlijWDPzkvIrElgzjrw7wFpwi7/iyLk1bA2M93i6GLk4hAQ2MkrcbuxhhnCWM
  ElcedjACuFsY5T48mYnSxcjJwevgJ3EwyXrwWwWAVWJae2XoOKCEidnPgGzRQWSJK5uuMsKYg
  sLBEpcmzUDzBYRUJE4ceIMO8hQZoEZTBIbzxxjgtjQwijxe00DG0gVm4CjxLxZG8FsTgEtiV9
  bFzKB2MwCFhKL3xxkh7DlJba/ncMMYksIKEq0LfnHDmFXSDROP8QEYatJXD23iXkCo9AsJAfO
  QjJqFpJRCxiZVzHaJBVlpmeU5CZm5ugaGhjoGhqaAmlDXWMDvcQq3US91FLdvPyikgxdQ73E8
  mK91OJiveLK3OScFL281JJNjMC4SilOldvBeGDfL71DjJIcTEqivOHehslCfEn5KZUZicUZ8U
  WlOanFhxhlODiUJHi5vYBygkWp6akVaZk5wBiHSUtw8CiJ8OaBpHmLCxJzizPTIVKnGBWlxHm
  NQWYKgCQySvPg2mBp5RKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV4TkCk8mXklcNNfAS1m
  Alpsx6cPsrgkESEl1cBUyeetx975unD2HOF7V5X2nfLo7mXbsLtD/eERn+XcdQqHer76rbix+
  ThX/skpf8/NUhPeky9/arru/Q3aqt+2h1sy1Ep6T3jO4F7ZsT2nap1MgpmrIueF6OaD767297
  xfacKtrLzs7sbqnsnnE9ZazuJ8EGu8IvPDwrbik6Y9W2sE/ixwfSJ+KM7gmwEHl+buF3Lh6kb
  fzBQX1fJ98Dl+3uJQRfVdT+EvaVXrVzO9UOnsZPuo0cFRLOs+3TbNdH7Uy8U7SkP/xtn1ymzM
  vzsjznP6f+lvmuf/LGtW/3P5ssLtaeefRPOxnkp5qT+h8tDdylSu1OV8SxYedm9R/zQn8GCgj
  9wjgYNfX64JeHBZiaU4I9FQi7moOBEAeRlAyqYDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-17.tower-732.messagelabs.com!1664175364!286688!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16108 invoked from network); 26 Sep 2022 06:56:05 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-17.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Sep 2022 06:56:05 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id AA3F01AE;
        Mon, 26 Sep 2022 07:56:04 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9E29E1AC;
        Mon, 26 Sep 2022 07:56:04 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 26 Sep 2022 07:55:59 +0100
Message-ID: <f34a180c-1d24-7780-7472-3f054fa35f59@fujitsu.com>
Date:   Mon, 26 Sep 2022 14:55:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com> <Yy4xrlC2lt156nsV@nvidia.com>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Yy4xrlC2lt156nsV@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/9/24 6:22, Jason Gunthorpe wrote:
> On Fri, Jul 08, 2022 at 04:02:36AM +0000, yangx.jy@fujitsu.com wrote:
>> +static enum resp_states atomic_write_reply(struct rxe_qp *qp,
>> +					   struct rxe_pkt_info *pkt)
>> +{
>> +	u64 src, *dst;
>> +	struct resp_res *res = qp->resp.res;
>> +	struct rxe_mr *mr = qp->resp.mr;
>> +	int payload = payload_size(pkt);
>> +
>> +	if (!res) {
>> +		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
>> +		qp->resp.res = res;
>> +	}
>> +
>> +	if (!res->replay) {
>> +#ifdef CONFIG_64BIT
>> +		memcpy(&src, payload_addr(pkt), payload);
>> +
>> +		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
>> +		/* check vaddr is 8 bytes aligned. */
>> +		if (!dst || (uintptr_t)dst & 7)
>> +			return RESPST_ERR_MISALIGNED_ATOMIC;
>> +
>> +		/* Do atomic write after all prior operations have completed */
>> +		smp_store_release(dst, src);
> 
> Someone needs to fix iova_to_vaddr to do the missing kmap, we can't
> just assume you can cast a u64 pfn to a vaddr like this.

Hi Jason,
Cc Ira,

When using PMEM with DAX mode(devdax or fsdax), we cannot ensure that 
iova_to_vaddr() can cast a u64 pfn to a vaddr, right? so we have to 
replace page_address() with kmap_local_page().

Without Ira's PKS patch set, I didn't see any failure when accessing 
remote PMEM with devdax mode by RDMA based on RXE. I don't know why I 
cannot trigger any failure in the condition.

> 
>> +		/* decrease resp.resid to zero */
>> +		qp->resp.resid -= sizeof(payload);
>> +
>> +		qp->resp.msn++;
>> +
>> +		/* next expected psn, read handles this separately */
>> +		qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
>> +		qp->resp.ack_psn = qp->resp.psn;
>> +
>> +		qp->resp.opcode = pkt->opcode;
>> +		qp->resp.status = IB_WC_SUCCESS;
>> +
>> +		return RESPST_ACKNOWLEDGE;
>> +#else
>> +		pr_err("32-bit arch doesn't support 8-byte atomic write\n");
>> +		return RESPST_ERR_UNSUPPORTED_OPCODE;
> 
> No print on receiving a remote packet

OK

Best Regards,
Xiao Yang

> 
> Jason
