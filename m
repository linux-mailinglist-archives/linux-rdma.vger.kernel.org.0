Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EEBB2B23
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfINL7I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Sep 2019 07:59:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57286 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbfINL7I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 14 Sep 2019 07:59:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8EBsHtj163236;
        Sat, 14 Sep 2019 11:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=QHjuUQs7IpLV6cdtA30CyA/V8h3Ed694WkiL4Pezj1c=;
 b=I0I6TgYaJWs2Hj9OVFqV3GAUkZvsdnlg7mL17zveS4ycVWiHjmpyRz6dzzOg+3dKitCN
 0iG8qjPFSQbWeqwebpDqLh9ZEGQxnt1DWImG72wYlcYGIZSPSEmc5jAdzOkJZO0b+w6I
 CwG1NoXBRaP4URgFoSouqPxWgjUgqYtB8falirwYkcn/uWbcDkZ1o7bkvUhjLD0wAIU7
 gAAWwHRNi+UfEbO6VHRJj4JPrOpq8emEMhL2W1Dk35InvoDcGqegfG+XREf+jhcrrp1H
 TjQYOvQDCETWNyzrIaqjm41GQNQ1KblBIDiSBGacV0aRbjEeTOYGF3u9ewQVZFqtCIHo TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v0qmt14p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 11:59:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8EBx3fp158627;
        Sat, 14 Sep 2019 11:59:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2v0p8smjgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 11:59:04 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8EBwOwL007370;
        Sat, 14 Sep 2019 11:58:24 GMT
Received: from dhcp-10-65-145-190.vpn.oracle.com (/10.65.145.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 14 Sep 2019 04:58:24 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: rdma_restrack_add/del in uverbs_cmd.c
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <CALq1K=LeU+SL+QdvD1enMUK7NcwNuGf2_c9DqwTkUz4udpGHcg@mail.gmail.com>
Date:   Sat, 14 Sep 2019 13:58:21 +0200
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DB75A55-592B-44B3-BD07-353DA2726FD1@oracle.com>
References: <7259675D-4D9D-4204-9D9F-BCA3048442E4@oracle.com>
 <CALq1K=LeU+SL+QdvD1enMUK7NcwNuGf2_c9DqwTkUz4udpGHcg@mail.gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909140127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909140127
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

:-)


> On 14 Sep 2019, at 13:55, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> Take a look in verb.c
> ib_destroy_cq_user()
>=20
> On Sat, Sep 14, 2019, 13:23 H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
> Hi,
>=20
> Sorry if this question has an obvious answer.
>=20
> In uverbs_cmd.c::create_cq(), there is a call to rdma_restrack_add(). =
I cannot find the parenthetical corresponding rdma_restrack_del(). I do =
not see it in rdma_core.c nor in uverbs_cmd.c.
>=20
> uverbs_destroy_uobject() calls the destroy_hw(), so it bypasses the =
(in this case)  ib_destroy_cq_user() which would have called =
rdma_restrack_del().
>=20
> I am probably missing something obvious, so my apologies for this =
noise in advance.
>=20
>=20
> Thxs, H=C3=A5kon
>=20

