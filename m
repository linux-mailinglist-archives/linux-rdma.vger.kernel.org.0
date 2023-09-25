Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF777AD54F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 12:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIYKFU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjIYKEw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 06:04:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE075FC;
        Mon, 25 Sep 2023 03:02:45 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P9IIv5007872;
        Mon, 25 Sep 2023 10:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oRThFD41Ci0117gK7HXauQTUKRM1npJ8c/LyCqHPDMo=;
 b=CjJvLPKc4Hb+LXDgu0NU0h7gi5jqB64x910WDlQM1vJXi/Bm+pl/UxyH2ua3SlEagloC
 QTiOkJEaAeGj9AUZRac+4Kc7fbyLKMHqEllwLLWGn2xoi1gbb2Q1g+4u7Tb92VP0R6T6
 Dl8EdBPZU+6V6WLc6muVqOFdq+yCNqc6XQnrWdxqNFq7xIG2xOeXf3UzzBk7ra2XOaCJ
 kBTiml3J56WQzPYpv6DgT8uEgu0i9HkAfcPWcv/BR3lgo6dZlLB8h/Hw97CXh/jBJ5o5
 kIvlVCaYCM/6P0q+oeRPgi9cLAqqNAcBiaGRweYdfkJ7HlVVQSn2D/yj9duLe3k9M4ma wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb7euh0u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:02:40 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38P9JVn8010413;
        Mon, 25 Sep 2023 10:02:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb7euh0su-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:02:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38P90Ghu010996;
        Mon, 25 Sep 2023 09:43:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabuk0xtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 09:43:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38P9hYHC6554266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 09:43:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D16320040;
        Mon, 25 Sep 2023 09:43:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC0952004B;
        Mon, 25 Sep 2023 09:43:33 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 25 Sep 2023 09:43:33 +0000 (GMT)
Message-ID: <3d1b5c12-971f-3464-5f28-79477f1f9eb2@linux.ibm.com>
Date:   Mon, 25 Sep 2023 11:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
To:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
 <0902f55b-0d51-7f4d-0a9e-4b9423217fcf@linux.ibm.com>
 <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ee2a5f8c-4119-c84a-05bc-03015e6c9bea@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o5MfwsYE1QDT0AHAM4mxbAkdXlEvuL51
X-Proofpoint-GUID: RCiW3PxYH-VBcYxaZX_cEG-7XRFcRlb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=882 spamscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250073
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 25.09.23 10:29, D. Wythe wrote:
> Hi Wenjia,
> 
>>
>> this is unfortunately not sufficient for this fix. You have to make sure that is not a life-time problem. Even so, READ_ONCE() is also needed in this case.
>>
> 
> Life-time problem? If you means the smc will still be NULL in the future,  I don't really think so, smc is a local variable assigned by smc_clcsock_user_data.
> it's either NULL or a valid and unchanged value.
> 
> And READ_ONCE() is needed indeed, considering not make too much change, maybe we can protected following

The local variable smc is a pointer to the smc_sock structure, so the question is whether you can just do a READ_ONCE
and then continue to use the content of the smc_sock structure, even though e.g. a smc_close_active() may be going on in 
parallel. 

> 
> smc = smc_clcsock_user_data(sk);
> 
> with sk_callback_lock， which solves the same problem. What do you think?

In af_ops.syn_recv_sock() and thus also in smc_tcp_syn_recv_sock() 
sk is defined as const. So you cannot simply do take sk_callback_lock, that will create compiler errors.
 (same for smc_hs_congested() BTW)

If you are sure the contents of *smc are always valid, then READ_ONCE is all you need.

Maybe it is better to take a step back and consider what needs to be protected when (lifetime).
Just some thoughts (there may be ramifications that I am not aware of):
Maybe clcsock->sk->sk_user_data could be set to point to smc_sock as soon as the clc socket is created?
Isn't the smc socket always valid as long as the clc socket exists? 
Then sk_user_data would no longer indicate whether the callback functions were set to smc values, but would that matter?
Are there scenarios where it matters whether the old or the new callback function is called?
Why are the values restored in smc_close_active() if the clc socket is released shortly after anyhow?

You see I am wondering whether adding more locking, there is a way to make sure structures are safe to use.


