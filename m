Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F533CFE1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfFKO4S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 10:56:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44576 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388078AbfFKO4S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 10:56:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BEhYKh085083;
        Tue, 11 Jun 2019 14:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=OkRcXKgJ6DvpPbZS8da1jlQgdwPY24WbaHsc19EbiX4=;
 b=uHgnBPFn9jYBZfbN8/TETTAWf2LjDDR0OgRqvPiOQg4m7t6x8FFGVlcPb+rB2TJfcjau
 2LeUcY2MH5ieUvTvolzoQYccgxXPfDEPLycoxzfiTKT5P8Szj1naWWVDitfcSt5wpB/W
 UBp76y1LkelwiJohd2tZ3csnRtFZs42Cw/QJdV/DCnMnTVZVUstMhjfbkg7qwYAVZZod
 wWg3hffIf1ESg85FjDXO3O+LtkvcTp8BhjFMRyFBhozmHDmTDDR5wieR9bdeXNubq2It
 vX50JEU9nV+/IUjgOghsiYFBMVXm6rFL7urVgak7Bd4BnmOzAXchqZiHxhO+Zww3ZQsy /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t05nqnnaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 14:55:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BEsCju006215;
        Tue, 11 Jun 2019 14:55:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t0p9rbd5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 14:55:50 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5BEtlF1022481;
        Tue, 11 Jun 2019 14:55:48 GMT
Received: from dhcp-10-172-157-227.no.oracle.com (/10.172.157.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 07:55:47 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] RDMA/mlx4: Spread completion vectors for proxy CQs
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190610175336.GA4890@ziepe.ca>
Date:   Tue, 11 Jun 2019 16:55:44 +0200
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, jackm@dev.mellanox.co.il,
        majd@mellanox.com, OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D80856A-8EF5-4320-B525-F8B28758CAFD@oracle.com>
References: <20190218183302.1242676-1-haakon.bugge@oracle.com>
 <20190610175336.GA4890@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110098
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 10 Jun 2019, at 19:53, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Mon, Feb 18, 2019 at 07:33:02PM +0100, H=C3=A5kon Bugge wrote:
>> MAD packet sending/receiving is not properly virtualized in
>> CX-3. Hence, these are proxied through the PF driver. The proxying
>> uses UD QPs. The associated CQs are created with completion vector
>> zero.
>>=20
>> This leads to great imbalance in CPU processing, in particular during
>> heavy RDMA CM traffic.
>>=20
>> Solved by selecting the completion vector on a round-robin base.
>>=20
>> The imbalance can be demonstrated in a bare-metal environment, where
>> two nodes have instantiated 8 VFs each. This using dual ported HCAs,
>> so we have 16 vPorts per physical server.
>>=20
>> 64 processes are associated with each vPort and creates and destroys
>> one QP for each of the remote 64 processes. That is, 1024 QPs per
>> vPort, all in all 16K QPs. The QPs are created/destroyed using the
>> CM.
>>=20
>> Before this commit, we have (excluding all completion IRQs with zero
>> interrupts):
>>=20
>> 396: mlx4-1@0000:94:00.0 199126
>> 397: mlx4-2@0000:94:00.0 1
>>=20
>> With this commit:
>>=20
>> 396: mlx4-1@0000:94:00.0 12568
>> 397: mlx4-2@0000:94:00.0 50772
>> 398: mlx4-3@0000:94:00.0 10063
>> 399: mlx4-4@0000:94:00.0 50753
>> 400: mlx4-5@0000:94:00.0 6127
>> 401: mlx4-6@0000:94:00.0 6114
>> []
>> 414: mlx4-19@0000:94:00.0 6122
>> 415: mlx4-20@0000:94:00.0 6117
>>=20
>> The added pr_info shows:
>>=20
>> create_pv_resources: slave:0 port:1, vector:0, num_comp_vectors:62
>> create_pv_resources: slave:0 port:1, vector:1, num_comp_vectors:62
>> create_pv_resources: slave:0 port:2, vector:2, num_comp_vectors:62
>> create_pv_resources: slave:0 port:2, vector:3, num_comp_vectors:62
>> create_pv_resources: slave:1 port:1, vector:4, num_comp_vectors:62
>> create_pv_resources: slave:1 port:2, vector:5, num_comp_vectors:62
>> []
>> create_pv_resources: slave:8 port:2, vector:18, num_comp_vectors:62
>> create_pv_resources: slave:8 port:1, vector:19, num_comp_vectors:62
>>=20
>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> ---
>> drivers/infiniband/hw/mlx4/mad.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>=20
> This has been on patchworks for too long. Is it still relevant, or
> were you going to respin this with Chuck's 'least loaded' idea?

Let me send a commit based on the least loaded idea this week.


Thxs, H=C3=A5kon

>=20
> Thanks,
> Jason

