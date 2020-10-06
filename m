Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D341284C98
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJFNej (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 09:34:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51600 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 09:34:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096DUJep128009;
        Tue, 6 Oct 2020 13:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hrdDx4xjXBxe+YvPeQzNCPVCo8qpRCKf906AxyhHMD4=;
 b=prCAF5ZALX8g9eEaxsp3MS9jjvUcBFek+hmmz4yiCXFMvoYuNdIBvcVrlX07BfRwcJdZ
 Z5ZS8eIzYVA5aBGjlntdqHef7sKm61Vi0+TjmifgdhzGzj1T1EOU93SltZBwbXWm/vgL
 K9hqfuCpJNGLxZJ66rVKa/Q59nHJyzbWcGaO8URqcH8rFcldeAy2l90dDzZtunlZmZ5w
 YD9jmfMLJnHExKIxii6n2BwYwzSGLzF4TK3szIpE+3qN9NWZoHpi1lbLSPW2S+zCO/9k
 xs3Jkce6KHVKCUhl6M6gviBz0hdUdHvOu1VwchV85KKdEcB592gOf8Zhq9EsI3bpcRTR vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33ym34h492-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 13:34:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096DV88X047091;
        Tue, 6 Oct 2020 13:34:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33yyjfjtc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 13:34:33 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 096DYWTD014484;
        Tue, 6 Oct 2020 13:34:32 GMT
Received: from dhcp-10-175-176-51.vpn.oracle.com (/10.175.176.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 06:34:31 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH for-next] IB/mlx4: Convert rej_tmout radix-tree to XArray
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <eb71d8bf-d6d2-0583-d771-1bf837bd4045@amazon.com>
Date:   Tue, 6 Oct 2020 15:34:27 +0200
Cc:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BBDCC54-9862-475A-B979-D7EAB494C078@oracle.com>
References: <1601989634-4595-1-git-send-email-haakon.bugge@oracle.com>
 <eb71d8bf-d6d2-0583-d771-1bf837bd4045@amazon.com>
To:     Gal Pressman <galpress@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=3 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060088
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 6 Oct 2020, at 15:14, Gal Pressman <galpress@amazon.com> wrote:
>=20
> On 06/10/2020 16:07, H=C3=A5kon Bugge wrote:
>> Fixes: b7d8e64fa9db ("IB/mlx4: Add support for REJ due to timeout")
>=20
> There shouldn't be a blank line here, and the commit hash doesn't =
exist.

Yep, you're right Gal. The Fixes line should read:

227a0e142e37 ("IB/mlx4: Add support for REJ due to timeout")

I'll let this one linger for a day to see if there are more comments and =
then send a v2.


Thxs, H=C3=A5kon

