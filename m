Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4536335E1B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfFENkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 09:40:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57026 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfFENkk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 09:40:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DTED2127174
        for <linux-rdma@vger.kernel.org>; Wed, 5 Jun 2019 13:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=corp-2018-07-02; bh=Pws2o6hzbs+cBVikaWDoT319wsEMQA1zqLbbnq5NNbo=;
 b=rHHlrwP7Qj3kzI3JdwNkESa6+u3MIrtHLzarU8lIU65tZ1+EmjSalSazcOD3LjjocU7A
 r9FxNFpHVqlPJMckxvW9Z4F/kWTs6IKAxvDvK0iXzXCk+9xN9f+uYTvPG21kuJzAKMo2
 08BaswfNgR4SA5Rm8PYYUIkvAIcjeuIPbV+R8IEYxfCP2Iy+/2gUW7SF1+Lp3RuKqBmA
 0HdSjxtib+qJXryWmNMTxbusb5KcTA5Mmul5LRAEN5oPZb7sZ/APRSivo7VuqKGQG2/C
 sdghendkYSrjn2DYybWnWvb80clEUrBwT87a7VGfsJDE1DYI+jsGQ97gktZ/87U7+OKz sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2suj0qjja6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 13:40:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DeXeD079452
        for <linux-rdma@vger.kernel.org>; Wed, 5 Jun 2019 13:40:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2swnha50xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 13:40:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x55DecHH024933
        for <linux-rdma@vger.kernel.org>; Wed, 5 Jun 2019 13:40:38 GMT
Received: from dhcp-10-172-157-159.no.oracle.com (/10.172.157.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 06:40:38 -0700
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: cma::addr_handler
Message-Id: <3B7DEF8D-966E-4C75-9A6D-A55A7B323A4F@oracle.com>
Date:   Wed, 5 Jun 2019 15:40:36 +0200
To:     OFED mailing list <linux-rdma@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=662
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=703 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Said function contains:

	if (!status && !id_priv->cma_dev) {
		status =3D cma_acquire_dev_by_src_ip(id_priv);
		if (status)
			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: =
failed to acquire device. status %d\n",
					     status);
	} else {
		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to =
resolve IP. status %d\n", status);
	}

Now, assuming status =3D=3D 0 and the device already has been acquired =
(id_priv->cma_dev !=3D NULL), we get the "error" message:

RDMA CM: ADDR_ERROR: failed to resolve IP. status 0

Probably not intentional.

So, would we agree to have:

	} else if (status) {
		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to =
resolve IP. status %d\n", status);
	}


instead?


Thxs, H=C3=A5kon

