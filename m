Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847717C712D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjJLPPh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347171AbjJLPPc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 11:15:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F385C0;
        Thu, 12 Oct 2023 08:15:30 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CFC6fs014877;
        Thu, 12 Oct 2023 15:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cu4OWlFcSkzAgQ1ZSUgowb6rWlcfQOprHpsTpGYe/I0=;
 b=Zzp61f7SDD20yZHSnGWqesTlBhZRuuPoLqAjpRrWTbkF/dRS10ZY1wbaObTb/RaF2PRB
 xGy8gFA9BclT6cTXjwSs3yQqcaNzgl7D78zUi3SHETVJYJEMcvCKFESBF09SdpTxKCNl
 Hk7NKJyOiLpbFKoZ0VIzCwjH2Q2BXL8sWV7RBk5ZbOMpPh2ufPugW3VLu3FDpGpZ1sZO
 BVHohNuDINuQuc+J48gvU4h1tAOQ1+7cos3J0FbrPFFvF8Eo7nw4ij4PfwK2sAng8enT
 7DdHNm/fz1swRhq8aD+EqFetZO3g07VtiU3+9Gws8O8YvC/4eUJbj1FF3k5kmHIZAguR 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk8084cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 15:15:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CFDFJs019790;
        Thu, 12 Oct 2023 15:15:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk8084bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 15:15:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CFCslU028188;
        Thu, 12 Oct 2023 15:15:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1ygf6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 15:15:19 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CFFHUv17891842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:15:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAA1958058;
        Thu, 12 Oct 2023 15:15:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1423458059;
        Thu, 12 Oct 2023 15:15:16 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 15:15:15 +0000 (GMT)
Message-ID: <bf52b502-6be0-467d-bf0a-5ae0e8d84fe8@linux.ibm.com>
Date:   Thu, 12 Oct 2023 17:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/5] net/smc: allow cdc msg send rather than drop it
 with NULL sndbuf_desc
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-4-git-send-email-alibuda@linux.alibaba.com>
 <5e2efb4b-1d26-4159-a2c7-b0107cb6381c@linux.ibm.com>
 <9f8f7a96-fcb0-3088-6d2f-d7e7d0fc83a1@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <9f8f7a96-fcb0-3088-6d2f-d7e7d0fc83a1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q7HZO0k_fuPjYd-RATOmZrt8Lv4X_j76
X-Proofpoint-ORIG-GUID: c0urxwtWFHVgYYKy7AKzynSqeqhVINgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12.10.23 04:49, D. Wythe wrote:
> 
> 
> On 10/12/23 4:37 AM, Wenjia Zhang wrote:
>>
>>
>> On 11.10.23 09:33, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> This patch re-fix the issues memtianed by commit 22a825c541d7
>>> ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").
>>>
>>> Blocking sending message do solve the issues though, but it also
>>> prevents the peer to receive the final message. Besides, in logic,
>>> whether the sndbuf_desc is NULL or not have no impact on the processing
>>> of cdc message sending.
>>>
>> Agree.
>>
>>> Hence that, this patch allow the cdc message sending but to check the
>>> sndbuf_desc with care in smc_cdc_tx_handler().
>>>
>>> Fixes: 22a825c541d7 ("net/smc: fix NULL sndbuf_desc in 
>>> smc_cdc_tx_handler()")
>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>> ---
>>>   net/smc/smc_cdc.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>>> index 01bdb79..3c06625 100644
>>> --- a/net/smc/smc_cdc.c
>>> +++ b/net/smc/smc_cdc.c
>>> @@ -28,13 +28,15 @@ static void smc_cdc_tx_handler(struct 
>>> smc_wr_tx_pend_priv *pnd_snd,
>>>   {
>>>       struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend 
>>> *)pnd_snd;
>>>       struct smc_connection *conn = cdcpend->conn;
>>> +    struct smc_buf_desc *sndbuf_desc;
>>>       struct smc_sock *smc;
>>>       int diff;
>>>   +    sndbuf_desc = conn->sndbuf_desc;
>>>       smc = container_of(conn, struct smc_sock, conn);
>>>       bh_lock_sock(&smc->sk);
>>> -    if (!wc_status) {
>>> -        diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
>>> +    if (!wc_status && sndbuf_desc) {
>>> +        diff = smc_curs_diff(sndbuf_desc->len,
>> How could this guarantee that the sndbuf_desc would not be NULL?
>>
> 
> It can not guarantee he sndbuf_desc would not be NULL, but it will prevents
> the smc_cdc_tx_handler() to access a NULL sndbuf_desc. So that we
> can avoid the panic descried in commit 22a825c541d7
> ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").
> 
got it, thanks!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

>>> &cdcpend->conn->tx_curs_fin,
>>>                        &cdcpend->cursor);
>>>           /* sndbuf_space is decreased in smc_sendmsg */
>>> @@ -114,9 +116,6 @@ int smc_cdc_msg_send(struct smc_connection *conn,
>>>       union smc_host_cursor cfed;
>>>       int rc;
>>>   -    if (unlikely(!READ_ONCE(conn->sndbuf_desc)))
>>> -        return -ENOBUFS;
>>> -
>>>       smc_cdc_add_pending_send(conn, pend);
>>>         conn->tx_cdc_seq++;
> 
