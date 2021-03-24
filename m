Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA347078
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 05:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhCXE2Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 00:28:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhCXE1q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Mar 2021 00:27:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O4RheO180285;
        Wed, 24 Mar 2021 04:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=EiILoXRNumBgyMtSOPmTA8P9yvHUuPbVCiUEalrfSC0=;
 b=FfJXtPFb4ltWUdcRZbcLUghrP8f+EHzjmp5v9hZ4B0lvYVk/fAOp9whq/47UfSfe0tsB
 uFKQu6G8yXb54LKLJXEOyaCvPwdx0LxdMXtRluA289qUFIkoc4HbNdrUY6qg0a1jhYj1
 3Adbz3Lu3mB8eGAz8qy+VS7G/Yd8G+LTmtaAP9VszB4+UXGSr0fuYOb/AmdeG//xqHQt
 lF/lXo8wpQtyVWR0djY3cy/KmUafvNmH7I39rXSYaFbfHpdbKf1ou56sGhYCplz8vAKC
 7HRTfYOfnglo8QIfKbmmPpKuP2rrmTwqirTyu+n5uoLMFMQnN/olKGnZyBywnMTza46N ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8fr9c59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 04:27:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12O4KASr168794;
        Wed, 24 Mar 2021 04:27:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37dttstrvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 04:27:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12O4RdJV006553;
        Wed, 24 Mar 2021 04:27:39 GMT
Received: from dhcp-10-159-154-41.vpn.oracle.com (/10.159.154.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Mar 2021 21:27:39 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
From:   Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
In-Reply-To: <20210323231321.GF2710221@ziepe.ca>
Date:   Tue, 23 Mar 2021 21:27:38 -0700
Cc:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>,
        leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Jeffery Yoder <jeffery.yoder@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DFF7518-8818-445B-94AC-8EB2096446BE@oracle.com>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
 <20210323160756.GE2710221@ziepe.ca>
 <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
 <20210323231321.GF2710221@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.17)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240032
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240032
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Mar 23, 2021, at 4:13 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Tue, Mar 23, 2021 at 12:41:51PM -0700, Aruna Ramakrishna wrote:
>>   There is a far greater possibility of an order-8 allocation =
failing,
>>   esp. with the addition of __GFP_NORETRY , and the code would have =
to
>>   fall back to a lower order allocation more often than not (esp. on =
a
>>   long running system). Unless the performance gains from using =
order-8
>>   pages is significant (and it does not seem that way to me), we can =
just
>>   skip this step and directly go to the lower order allocation.
>=20
> Do not send HTML mails.

I apologize; I=E2=80=99ve fixed the setting now.

>=20
> Do you have benchmarks that show the performance of the high order
> pages is not relavent? I'm a bit surprised to hear that
>=20

I guess my point was more to the effect that an order-8 alloc will fail =
more often than not, in this flow. For instance, when we were debugging =
the latency spikes here, this was the typical buddyinfo output on that =
system:

Node 0, zone      DMA      0      1      1      2      3      0      1   =
   0      1      1      3=20
Node 0, zone    DMA32      7      7      7      6     10      2      6   =
   7      6      2    306=20
Node 0, zone   Normal   3390  51354  17574   6556   1586     26      2   =
   1      0      0      0=20
Node 1, zone   Normal  11519  23315  23306   9738     73      2      0   =
   1      0      0      0=20

I think this level of fragmentation is pretty normal on long running =
systems. Here, in the reg_mr flow, the first try (order-8) alloc will =
probably fail 9 times out of 10 (esp. after the addition of GFP_NORETRY =
flag), and then as fallback, the code tries to allocate a lower order, =
and if that too fails, it allocates a page. I think it makes sense to =
just avoid trying an order-8 alloc here.

Thanks,
Aruna


> This code really needs some attention to use a proper
> scatter/gather. I understand the chip can do it, just some of the
> software layers need to be stripped away so it can form the right SGL
> in the HW.
>=20
> Jason

