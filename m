Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28C171E87
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 15:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733068AbgB0O2b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 09:28:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbgB0O2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 09:28:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01REOjOX073587;
        Thu, 27 Feb 2020 14:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=wGcJXjxI8eNnQZB4OELo+Ip4jZtWH9Z1eOVxb97YW6Y=;
 b=g0v9/RUJfloVbfqce20j0tnuGCN2gAUNXIn9eyNKwYQMBr+vZCRhG4QKufRyIOfujguT
 8rzKR/NaiV0kk4W6nlTxWclD0BnXf4zGsNVt3wc2A2Q1ROINNMuS3IEm8YNvjeP47Fmc
 QdWwqRjmOCVR1qxRIqbJLbcYd6y+2yiJDUUnNCkU40yeU5nsDVITJogQ1do8GtAn5/yk
 622dCgB/HqAOJIok4A2EekBRAG8bhuDDzg0beiDTnkGEzxTPgLN+WmAmYVhhjK5TfBq6
 bkbG5oJfVHGTonDRzkdWw3SPXbS85j1aF+VlXuIv/JOTvkMIFyKlCcusLz9w3fKY9bXw 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ydcsnk95p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 14:28:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RESJXo091651;
        Thu, 27 Feb 2020 14:28:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ydcs9a2pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 14:28:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RESQaL026748;
        Thu, 27 Feb 2020 14:28:26 GMT
Received: from dhcp-10-172-157-208.no.oracle.com (/10.172.157.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 06:28:26 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Maybe a race condition in net/rds/rdma.c?
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <afd9225d-5c43-8cc7-0eed-455837b53e10@gmail.com>
Date:   Thu, 27 Feb 2020 15:28:24 +0100
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8EB4A77-77D7-41EB-9021-EA7BB8C3FA5B@oracle.com>
References: <afd9225d-5c43-8cc7-0eed-455837b53e10@gmail.com>
To:     zerons <sironhide0null@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=1 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=1 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270114
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 18 Feb 2020, at 14:13, zerons <sironhide0null@gmail.com> wrote:
>=20
> Hi, all
>=20
> In net/rds/rdma.c
> =
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net=
/rds/rdma.c?h=3Dv5.5.3#n419),
> there may be a race condition between rds_rdma_unuse() and =
rds_free_mr().
>=20
> It seems that this one need some specific devices to run test,
> unfortunately, I don't have any of these.
> I've already sent two emails to the maintainer for help, no response =
yet,
> (the email address may not be in use).
>=20
> 0) in rds_recv_incoming_exthdrs(), it calls rds_rdma_unuse() when =
receive an
> extension header with force=3D0, if the victim mr does not have =
RDS_RDMA_USE_ONCE
> flag set, then the mr would stay in the rbtree. Without any lock, it =
tries to
> call mr->r_trans->sync_mr().
>=20
> 1) in rds_free_mr(), the same mr is found, and then freed. The =
mr->r_refcount
> doesn't change while rds_mr_tree_walk().
>=20
> 0) back in rds_rdma_unuse(), the victim mr get used again, call
> mr->r_trans->sync_mr().
>=20
> Could this race condition actually happen?
>=20
> Thank you.

Hi Peng,


I will have someone to look at this one.

Thanks for your report,


H=C3=A5kon




