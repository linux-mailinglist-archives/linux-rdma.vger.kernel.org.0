Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385DF7AEB22
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjIZLOi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIZLOh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 07:14:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCDEE9;
        Tue, 26 Sep 2023 04:14:31 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QB6MbT028500;
        Tue, 26 Sep 2023 11:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SVmZkxj6SA3hzapomKc3tjR/6ySaAdnYPzjaecJ/A6k=;
 b=cDU9yZQ1VZWTpkoyMCNxxBlw+FMkr0sWUE6gPN8uAvsxAzfUc5AxQZG2ogTe4kvxbiA0
 824xW2lvns1Esk4q6urv2dPZ1c+Y/EOqjh7OJ7vHayCP1biQpVAgMGVr7Ro7fR5nn2ie
 n4OwZipqqWkyFXZ8x0mNKhf7UiUSKD7ir7loVMN5QV/CsRjNKtOaeRxXYczxwoLpoO+t
 CgXmCIY05gQLIawrx/+8ZxEaquP3PFFPHTWLi57znLGIppwubdStSsiDPYvz13BEnkd7
 R+pD5ZGoe5KdU5Ju2YbfeRaMyMzVuqMa98pJH19wMpjY7axNPb/3Rhz6Zgg9k2/8dPbU Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbwueghwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 11:14:09 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QB6xDq032579;
        Tue, 26 Sep 2023 11:14:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbwueghwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 11:14:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38QB17k1008126;
        Tue, 26 Sep 2023 11:14:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqyb6pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 11:14:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QBE4W722610496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 11:14:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E27C720043;
        Tue, 26 Sep 2023 11:14:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A918220040;
        Tue, 26 Sep 2023 11:14:04 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 11:14:04 +0000 (GMT)
Message-ID: <76a74084-a900-d559-1f63-deff84e5848a@linux.ibm.com>
Date:   Tue, 26 Sep 2023 13:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Albert Huang <huangjie.albert@bytedance.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230926104831.GJ1642130@unreal>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20230926104831.GJ1642130@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZDkRJrc-8DDCrdra6qNLwn3HL9C1tAGf
X-Proofpoint-GUID: 5cpoe31gYOgKmzBmR1uCO4D8uepyTSlx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=540 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260095
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 26.09.23 12:48, Leon Romanovsky wrote:
> This patch made me wonder, why doesn't SMC use RDMA-CM like all other
> in-kernel ULPs which work over RDMA?
> 
> Thanks

The idea behind SMC is that it should look an feel to the applications
like TCP sockets. So for connection management it uses TCP over IP;
RDMA is just used for the data transfer.
