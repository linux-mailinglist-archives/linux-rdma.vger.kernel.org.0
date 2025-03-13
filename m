Return-Path: <linux-rdma+bounces-8650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD66A5F3E8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C79B3BC615
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802252676D9;
	Thu, 13 Mar 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mOfhreln"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFB7146585;
	Thu, 13 Mar 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867842; cv=none; b=euvAa/qDA+kS3aQWVjB2ohOYk0Q1IMAUCwt4SfZVyCI6Efx3nQ0ma+6NvlL5ZHs9FF8Khl8arXYeCyC1YVF5G+aQyx0qrHBpykOLS+z8jZ26Par+g/6iaR/Q6PeBF0zzlu1o36XzR6HuxD/FubRqFcUJ0TIU5l7qYzD89UnXUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867842; c=relaxed/simple;
	bh=qnEIcK5bdGMZiUamZN93eIPZHXZ0CPbZfkeYMs1VQek=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QBaLS2SaIxVt+JPuZwnRogTBB45NxKxkTAAcla2m21EwkPKaPmdaf+LiBG8mfrN/bRGcwsaIDO//+C6hAkQcTglNP3EhreQ5aeWMseeYRf8hZyFOufMg+IJ659CbdVx2NtJPXwp5qC8FWqopYqxk48DCBnOQcmMiGsQHk0NqEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mOfhreln; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741867833; x=1742472633; i=markus.elfring@web.de;
	bh=yYaVDeP1Xdy/g5FhSwAfNwJXShfkIqshNp0sKl5UzpQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mOfhreln0augtRuJWChz7sIUVk8cU/rZbtGCClbj7fh3P9V+BR11kvUATPHin5sp
	 Ed8T6Wplv4nHRNOmDVSjajWadXQOvlj4uHqLLMZPqgLYD2JITyxY/jAi5ebt/LPHc
	 C8JcMNxsjUwVesFxfI2oZkwd9/E14HsCLHst1/udlw2Pkc6E85S+6DAnjVorVRpz0
	 WWvReebrr1uiSvovp0gGwrZGf/4/5KnCHjeuZhusLmI+jFtCph+KZkfZ9Tpp9a3rL
	 C1bR7HR6WfpOuw6dgQM+kVP7f7O67PQtJt7bpJpt9v41ks/6eE2cjcJgtJkaunsgL
	 xaxAhQhDnWR/yd2jlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.2]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwR05-1t34iD3k4j-00v5D5; Thu, 13
 Mar 2025 13:10:32 +0100
Message-ID: <2e9ae1d6-4bbb-470f-957f-bb6ea2e0829e@web.de>
Date: Thu, 13 Mar 2025 13:10:21 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-rdma@vger.kernel.org, Cheng Xu <chengyou@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kai Shen <kaishen@linux.alibaba.com>,
 Leon Romanovsky <leon@kernel.org>, Yang Li <yang.lee@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v2] RDMA/erdma: Fix exception handling in
 erdma_accept_newconn()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BiWWEZilTrD/yJJQ5T0c/kPNzZSysh6jFIFCQ76SUBCnSl1vWUr
 PcN57SAiKOtfCYBqhU4LyXjPxfiI+lOOElhE4unDWJwNKbDC4IK10ct3ZcI81XWbyRZJJOa
 oh6rSJfnUnOkHZyElh/p7py947uJrDcB8cSgf40XB6ybRfIEXLFtstqot1jkiVcUj/3Ma5u
 6y+Ikg6ypUXq5ARq1+Utw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j7JPxJiDw48=;XfhM9AbsBls2oBkC2Naf0RxiDLP
 N2QZc1vvEv4SJqZb904UtN8dZ+2jI4Daz5SH4F9OMnnuq2WCyQzklJfIv3GfreD8Yxq7YXSGK
 RytUdCj16H+i+YmB44KBxKjadoEkEZPRo7M4biRHCT3d+w7uLAz04tYr8o90VW2nOdMHx/uaU
 MKs7YqWKc4KNjZowFjuT8PKpQd2NjRiDXSike6Kn8lPEfc49g/DOpfkZabOPhpAUGCVUo4zZb
 qfG/5YEynVeg88b5E/fzx/N9HXrdmn/oDRdTVoNvTn6XQue2yxpZhKYdMTW+FKJzxGSRO8AHV
 xw8vl1blOakiSibPhwoEHgfnoqeTP8EAKJod/y2z+RCJiobpf3jx4eJchlj6K7ZIlhTPnIKyV
 GPnwkGva4w36gMLwbPMcmmf6Ulfxb4jL879i3dK7fSV/UxWwep8JqA7wc0vyEhs6cGKZAF/r2
 OMQSJnaT+SMPRlLes0YhUUzqTfPLCMUDbGfWZwqlWNyYziphgYcQ5XpUPoI6LVDPdrXqUoI56
 KRqFKsEFtiG/13YTEq+/thzIRZIE0eAH+aGHrQNrK4xLwZRy3pe3YwWIsImG/jK4k5ZxLGk2R
 VjvNG1bv0CoKRnesrIzhMvbeNn6a2nKVH7MDHZUwzneMtMefiaGwo4Svy5umdzoATp5GE/EEL
 W17zg931elx9XGMPB9UZsZQ1U678Vir30tMnB8hBPlRghsxtqSGD/DrMJzcnKN05sVtm9FECL
 ybkYBBnw/+8a1mR5hvX8USsl2VcfXV0Xzz+bShp1XyqHWEkxyhIufMID3SUndbwPjrO1a15Jk
 IrrxRGrdcpN/aiWB5ZZI5ANZ9I6jz0SvDI+4zYg5Vlrh6M2xz06y+dOaQ5ZbtsVCcoC8a5Wae
 UkD+fgsSFs0RIXViqIe/RN1PAlSL3bdLZ0Q9G9XLeBzB+s/MpuexenINN5Hv9MpFzGa9OxSHI
 YgZo2f9FXsaBxVqQuTuM6ZmI4H0Z4yNoXfHrHcJ3tXjaxwQPr6FP7OMQMjfVY350LN9Y/VdZd
 Y8U7PabL2t8ShSfE5zCkyEdNT4RyIG5vGwIHUjIrJXup+ZMhBDii9GFEdub0ZbujrOb8IK1fq
 HIyc2iq1jsul1TIlYbNg9k7EQRk+lSA5sJ1ncZ9/Y4vm8kjI2pBCRPuoKSAPXZVnkC5DzsaBF
 uU513IJi3LuXH4KGW8wX+Ls1TNlCloZijt/VhOUxuVC2REpdRCRwy9B0AuVdJ3SgIHI3SDC8c
 lSc2KismVtxPz/zNA4WQZKNdHLQBtKKo6s5bm+VnSRuHLTY3+L9otjtIE3IO1ZAXjdgF/Q11c
 2yNk/aWQUWYFLGvtiKMC7mx0KrDD7Rea7X1qKnGFWVcAbNrAULO09tUvHNgvsNUi7N/9uhexX
 ibIh6DS+dkZyciEE6hyhJXmt8hnWBD0/YVb3yIYynTqHvGVAtxPCDz3+tJK3N2Dq9uW+rb95P
 qlOjW5RSZcBZWqdkdbpqwplzig1SToO1WdVCdOox8ZAbnHarY

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 13 Mar 2025 11:44:50 +0100

The label =E2=80=9Cerror=E2=80=9D was used to jump to another pointer chec=
k despite of
the detail in the implementation of the function =E2=80=9Cerdma_accept_new=
conn=E2=80=9D
that it was determined already that corresponding variables contained
still null pointers.

1. Thus return directly if
   * the cep state is not the value =E2=80=9CERDMA_EPSTATE_LISTENING=E2=80=
=9D
     or
   * a call of the function =E2=80=9Cerdma_cep_alloc=E2=80=9D failed.

2. Use more appropriate labels instead.

3. Delete two questionable checks.

4. Omit extra initialisations (for the variables =E2=80=9Cnew_cep=E2=80=9D=
, =E2=80=9Cnew_s=E2=80=9D and =E2=80=9Cret=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 920d93eac8b9 ("RDMA/erdma: Add connection management (CM) support")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

See also:
* https://lore.kernel.org/cocci/167179d0-e1ea-39a8-4143-949ad57294c2@linux=
.alibaba.com/
* https://lkml.org/lkml/2023/3/19/191


V2:
The change suggestion was rebased on source files of the software =E2=80=
=9CLinux next-20250313=E2=80=9D.
A corresponding implementation detail was improved by the commit 834376892=
49e6a17b25e27712fbee292e42e7855
("RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()") on 2025-0=
3-06.


 drivers/infiniband/hw/erdma/erdma_cm.c | 37 +++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/h=
w/erdma/erdma_cm.c
index e0acc185e719..a7a79722e940 100644
=2D-- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -642,16 +642,16 @@ static int erdma_proc_mpareply(struct erdma_cep *cep=
)
 static void erdma_accept_newconn(struct erdma_cep *cep)
 {
 	struct socket *s =3D cep->sock;
-	struct socket *new_s =3D NULL;
-	struct erdma_cep *new_cep =3D NULL;
-	int ret =3D 0;
+	struct socket *new_s;
+	struct erdma_cep *new_cep;
+	int ret;

 	if (cep->state !=3D ERDMA_EPSTATE_LISTENING)
-		goto error;
+		return;

 	new_cep =3D erdma_cep_alloc(cep->dev);
 	if (!new_cep)
-		goto error;
+		return;

 	/*
 	 * 4: Allocate a sufficient number of work elements
@@ -659,7 +659,7 @@ static void erdma_accept_newconn(struct erdma_cep *cep=
)
 	 * events, MPA header processing + MPA timeout.
 	 */
 	if (erdma_cm_alloc_work(new_cep, 4) !=3D 0)
-		goto error;
+		goto put_cep;

 	/*
 	 * Copy saved socket callbacks from listening CEP
@@ -671,7 +671,7 @@ static void erdma_accept_newconn(struct erdma_cep *cep=
)

 	ret =3D kernel_accept(s, &new_s, O_NONBLOCK);
 	if (ret !=3D 0)
-		goto error;
+		goto put_cep;

 	new_cep->sock =3D new_s;
 	erdma_cep_get(new_cep);
@@ -682,7 +682,7 @@ static void erdma_accept_newconn(struct erdma_cep *cep=
)

 	ret =3D erdma_cm_queue_work(new_cep, ERDMA_CM_WORK_MPATIMEOUT);
 	if (ret)
-		goto error;
+		goto disassoc_socket;

 	new_cep->listen_cep =3D cep;
 	erdma_cep_get(cep);
@@ -696,25 +696,20 @@ static void erdma_accept_newconn(struct erdma_cep *c=
ep)
 			new_cep->listen_cep =3D NULL;
 			if (ret) {
 				erdma_cep_set_free(new_cep);
-				goto error;
+				goto disassoc_socket;
 			}
 		}
 		erdma_cep_set_free(new_cep);
 	}
 	return;

-error:
-	if (new_cep) {
-		new_cep->state =3D ERDMA_EPSTATE_CLOSED;
-		erdma_cancel_mpatimer(new_cep);
-
-		erdma_cep_put(new_cep);
-	}
-
-	if (new_s) {
-		erdma_socket_disassoc(new_s);
-		sock_release(new_s);
-	}
+disassoc_socket:
+	erdma_socket_disassoc(new_s);
+	sock_release(new_s);
+	new_cep->state =3D ERDMA_EPSTATE_CLOSED;
+	erdma_cancel_mpatimer(new_cep);
+put_cep:
+	erdma_cep_put(new_cep);
 }

 static int erdma_newconn_connected(struct erdma_cep *cep)
=2D-
2.48.1


