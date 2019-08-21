Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F02981B8
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfHURre (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:47:34 -0400
Received: from mout.web.de ([212.227.15.4]:46117 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfHURre (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 13:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566409631;
        bh=ZFDz5Uwxh5xJpbrXcIitmO9awwymC/HkpqKW4+5ZQ0Q=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=G1y/OSgjuh29TtHgCXx6i0i6d6mDd57sSfoiTQAZb/+z64bzTAEKhLSmppF9RawcK
         2crvPhqMy3gzKHlr/fZ3Uftf950GZ9tA+SmyPm14VvParUVuVe477/P3tTmDP+DkPQ
         /1Se97k+XuoABATjnxvYH8RxZ3deRDl7wxKgWqYg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.9.44]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9GHu-1i6aZt28TO-00CfPa; Wed, 21
 Aug 2019 19:47:11 +0200
To:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes.berg@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Tatyana Nikolova <Tatyana.E.Nikolova@intel.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5bPATCH=5d_RDMA/iwpm=3a_Delete_unnecessary_checks_before?=
 =?UTF-8?B?IHRoZSBtYWNybyBjYWxsIOKAnGRldl9rZnJlZV9za2LigJ0=?=
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <16df4c50-1f61-d7c4-3fc8-3073666d281d@web.de>
Date:   Wed, 21 Aug 2019 19:47:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L6Ea/W8ve94X5vE4KMZPOVjjkD229CqsQL9fnPwPv+3LtnWC3Bo
 DUPxc6A/d7bM7atRIRs9bnTalQC0i8eLWydJNrmw8WGkTzjnZ2We0R2LeiJ2sN6oDZHBIdC
 ry8QbomXsRecWUwRVbPtP81H6f18q4EvBVNBDDpF8v6kzHgtEvDAvZZsxHyd5LYJ+cUUVIz
 fHoX9eQg2BKkFU4YhNBNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gr2900Rzoi8=:RKnXqCiWm1OesEhtWrhpFZ
 geTFvX4x6sznHNcl9RvkmJp9wmH+olxXCGXYiORhQy1rdlRW1b8qc3Wl7gpJtnE0EHePw5pri
 iIejT5yLxgIKrWpwdVvp+75rVbNZ809L9atScMJZNV+XeOBU8T2ObGE9cgvYALz+1Von3bIsQ
 KDimBtyNTH1qsML2WbVZCgcJvYz1lvDkVXv1nfqAfblzcspZkTa9blXNfzjq/IXspJ3l2YmJr
 Uyfwq1bIHgZyyl5iiUKp6HBfKr6zKNEBOgyCEySzvwMDxWMvfrO7Zr15lPYceoPBmdHxiAKhE
 H0Qfeql/VJPqGijAmmMhA8GEfuO2L+VlZr2vK17sUL4feBOIPRujiDpc2ucSwiciiOWwUXSdR
 yvNRS3IcX2XStvYdz8fDboeNs03dU2+pQqzK5pX4S8HbAyLfslmvtM5tZDS+7V/pn45cuu83b
 FD0xC71z4jJuJ01vsaxWYb04Vikrk51cc3A8ZQwtVl4Mr8hh3M3UFmh4QjI8OV57CezhX0lOL
 4XWYfaoiQ55JhK5cOjYgpVIjo8IcoSfW59iAZfNmEGkEncynsR9aGeeqr+SXA3TE/N80b2PqI
 buVE50rRkwR5ooJ/CRHVYs0GOW0CndIaWTgjyurnwfSuKdI7UCDdlmJJ3klUR667iZmuXpYn8
 laWtpPZ++fIUxJdfA6BrKpYOYmFBJw3AF1LZrHSH9OOmxeTB26dCBqJIzf1yJsjxyxKJG8eKd
 jj67xPav+FIMIPBoFSDLEHaWoQtjZr+ibbzz1AB5qWNhvvSOWuJ/V9OBx2TQH1VSdHGmwdnB1
 h8ercM6/oidl/OOQX6bEn+hg8TpOT+xpjrEcuAvIp4f3AXjACJFvmepYM6IqWmae0FYQgyaOV
 O2+MZkgPKvNWq87YKDvDpantsDbBxUAFYSHzwVLbtZsle1bUdHGUwjEAj0+sM633tPIojguNQ
 OcLqoqI5WxUHyZv3DbCoJIQ/3XTVCkxslMElU+IOZ+z/7rI84YfT6lbXJSO0bn2KcBWjpKpLc
 pFpju9mJpFKOkaNLURxQzrJfRZl7fninkBGHcUK1jJd4DXQiGRG2kU5TgjJY6vlm8xXyYfJ9Y
 il7X4Fy/UJe+7PamlCRdsx180rrCuEV4EJl8UhrzJWViwOVH5PScsczDBWPwlB085Za7+QFhz
 MXMCk=
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 21 Aug 2019 19:30:09 +0200

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the shown calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/infiniband/core/iwpm_msg.c  | 9 +++------
 drivers/infiniband/core/iwpm_util.c | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/=
iwpm_msg.c
index f1a873d4e842..46686990a827 100644
=2D-- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -124,8 +124,7 @@ int iwpm_register_pid(struct iwpm_dev_data *pm_msg, u8=
 nl_client)
 	return ret;
 pid_query_error:
 	pr_info("%s: %s (client =3D %d)\n", __func__, err_str, nl_client);
-	if (skb)
-		dev_kfree_skb(skb);
+	dev_kfree_skb(skb);
 	if (nlmsg_request)
 		iwpm_free_nlmsg_request(&nlmsg_request->kref);
 	return ret;
@@ -214,8 +213,7 @@ int iwpm_add_mapping(struct iwpm_sa_data *pm_msg, u8 n=
l_client)
 add_mapping_error:
 	pr_info("%s: %s (client =3D %d)\n", __func__, err_str, nl_client);
 add_mapping_error_nowarn:
-	if (skb)
-		dev_kfree_skb(skb);
+	dev_kfree_skb(skb);
 	if (nlmsg_request)
 		iwpm_free_nlmsg_request(&nlmsg_request->kref);
 	return ret;
@@ -308,8 +306,7 @@ int iwpm_add_and_query_mapping(struct iwpm_sa_data *pm=
_msg, u8 nl_client)
 query_mapping_error:
 	pr_info("%s: %s (client =3D %d)\n", __func__, err_str, nl_client);
 query_mapping_error_nowarn:
-	if (skb)
-		dev_kfree_skb(skb);
+	dev_kfree_skb(skb);
 	if (nlmsg_request)
 		iwpm_free_nlmsg_request(&nlmsg_request->kref);
 	return ret;
diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core=
/iwpm_util.c
index c7ad3499228c..13495b43dbc1 100644
=2D-- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -655,8 +655,7 @@ static int send_mapinfo_num(u32 mapping_num, u8 nl_cli=
ent, int iwpm_pid)
 	return 0;
 mapinfo_num_error:
 	pr_info("%s: %s\n", __func__, err_str);
-	if (skb)
-		dev_kfree_skb(skb);
+	dev_kfree_skb(skb);
 	return ret;
 }

@@ -778,8 +777,7 @@ int iwpm_send_mapinfo(u8 nl_client, int iwpm_pid)
 send_mapping_info_exit:
 	if (ret) {
 		pr_warn("%s: %s (ret =3D %d)\n", __func__, err_str, ret);
-		if (skb)
-			dev_kfree_skb(skb);
+		dev_kfree_skb(skb);
 		return ret;
 	}
 	send_nlmsg_done(skb, nl_client, iwpm_pid);
@@ -834,7 +832,6 @@ int iwpm_send_hello(u8 nl_client, int iwpm_pid, u16 ab=
i_version)
 	return 0;
 hello_num_error:
 	pr_info("%s: %s\n", __func__, err_str);
-	if (skb)
-		dev_kfree_skb(skb);
+	dev_kfree_skb(skb);
 	return ret;
 }
=2D-
2.23.0

