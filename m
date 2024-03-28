Return-Path: <linux-rdma+bounces-1441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA1387C399
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 20:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB301C216E0
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 19:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2A2763EE;
	Thu, 14 Mar 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AawEUCeJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428E7580F;
	Thu, 14 Mar 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444059; cv=none; b=IdOxNjVESB96QnFB8iyGJ7dP7/57btcgK1V5HwaVS9OIrD4ajOv4rhkX2UGQThpmTJVfZ1ooM131n/EQk3j8yCEtReFnJ1UpfaKoi9QzgEbUy4YTaTuMC+08iagEAcvSEm5BsBzlF2E9+/jIn6krJH8tUYNTbIAi6FCuDAYV/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444059; c=relaxed/simple;
	bh=jrbuO52ZBSIAk7BVgz4HVemMnghQxGKVn3QHhdB/BIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHij0hB9QESXpeQSruZ+w4ZufuPwqaHEiiq/C21BOuCBDrMdyzNhdnRxs1/Cxf75WATXluEt8MsjzxsG73umsQW55TYDllcqDaaMQs1Zlr8YtEZJCoNifoi3mqEz9qieCzNfAWjw/2UnDpXU4Q/TjZmzovotWCxbNrTKMkq1B5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AawEUCeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E36CCC43399;
	Thu, 14 Mar 2024 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710444058;
	bh=jrbuO52ZBSIAk7BVgz4HVemMnghQxGKVn3QHhdB/BIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AawEUCeJ92CVdpB5UNZlsotqi5btJGD2n/40jnPr2eMkFm1FBPJ2b3iytGe89gubn
	 86f1e5qrXYMjGq40gsrxhpPkoziZxyiRbjisOO++OpJHbg4lO0u9M+GpfEcIZrdU23
	 gCkVQQcJjbbrhMT/+PiWv+QgInUWN4ta+EoZfBhQEPlxcm4JQ0Tjz51ypy58i02SS3
	 jwEr1XtNEQy6tW7N97I06vMLKw5OhzW2Ov7Buoz179VHK4ljrVYK0HqDodxpOhn3Vi
	 5ySTxQi+/4SCOQbDVsQGVZSJ0twXtzvQBYw6YjT6OM37bOlzpMSbwiIdJxIwdu8Y0q
	 I5v/UiDs4FaPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2415C54E6E;
	Thu, 14 Mar 2024 19:20:58 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 14 Mar 2024 20:20:43 +0100
Subject: [PATCH 3/4] appletalk: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-jag-sysctl_remset_net-v1-3-aa26b44d29d9@samsung.com>
References: <20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com>
In-Reply-To: <20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, 
 Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, 
 Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org, 
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=XDIcCkZ78Jc0dTs1FMG4vIEa4qRq4WIrQqvTanRSSyI=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBl804YVY9Xw0++owa6LWglh5nII93WQz6ecjWxh
 SYP9NB91rKJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZfNOGAAKCRC6l81St5ZB
 TwAQC/0eqOCO1aPDMvrYgZcVtIBZQCNypI3Swj50+jfK2k7oWETTpG5ZOYvRAmucIsDOCDxPZso
 2JI1/CJerPS2MbD/gMYYgsmpGOfoRKo4jjsw8f+nlf/Zdgal6rjIXC1AXFYPJnX5JLYzWnVvZTt
 Oe1zmPOpSnrVZJevKI1L9do1c/SyKOpzAF5BEJXhFfjMyZsDQbqsj5rzLz2X814cru40+oRHbZb
 HdHsKqZM40d9vt587+0Fubzwl0EksSraSmhQRrqslPKFbl9YIW3gYPVMt9LpQDKINVWlNmJ1HwW
 oc1LpAy/gHYMcPzeS8UUcr2qGtmGrgpYT9L0q3Q6Fd0c6nPUgffV8d5AFqOWLgv3zFuAuyNGfTD
 6f7E+M6jTRzVOJdFR1WTVSr0iLmOjjkHaPtwjB5dw++OQV20WbgV4+mL0gOfa9CCkOac8QZCZK7
 tQLPVV9Bm/YDEyRxuqB0nf3GQ13SZpAmd11JqndFWYe3B6vPj7oGDB7PjkMTsGytXQFDs=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which will
reduce the overall build time size of the kernel and run time memory
bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from atalk_table ctl_table array.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/appletalk/sysctl_net_atalk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
index d945b7c0176d..7aebfe903242 100644
--- a/net/appletalk/sysctl_net_atalk.c
+++ b/net/appletalk/sysctl_net_atalk.c
@@ -40,7 +40,6 @@ static struct ctl_table atalk_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ },
 };
 
 static struct ctl_table_header *atalk_table_header;

-- 
2.43.0


