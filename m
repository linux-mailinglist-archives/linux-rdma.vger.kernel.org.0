Return-Path: <linux-rdma+bounces-8033-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C3A41A07
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 11:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342C716C959
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383A255E3D;
	Mon, 24 Feb 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="OQaz9fFU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D422505B3;
	Mon, 24 Feb 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391144; cv=none; b=fMaqvU0a4tX0dVBibSfX+grDrnzQyWP0BW/xm3SW3CeKWpcCR6ehRj/Kwqh7sgFhJSqwa8TcWb+Fq7Vey3AGknnInuVjNiq//+CFCxmnYqODw1RBUcO/W0CAd4SArprv856Q815vqo6RmjhB1JRaJ9U4k0PHMmiPsyZaIvu5YXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391144; c=relaxed/simple;
	bh=app8uTw0yG+Vwb/wnwjmafFZKLlyd0jMkiYjI0o50XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaiou+1MdefAqpnOigKc87K4DxEUB0rG8PeaeN1JieS7SFq2b06rCKInVi9FM8pcgjbLSOoAmqgl65SA3KnBcd10eOVgaK5hALVVKX9tzzM9QbkoEZLuZSrnpC1Xui0B0SZ0yPefwnWnwDmZjq82vn9IqTIPoU6S+oRkZqT+uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=OQaz9fFU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4522F4340D;
	Mon, 24 Feb 2025 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1740391140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTOktiECV7C6ObFWMliMfOPrgqsU0Ar4xpLJ1Kj/O04=;
	b=OQaz9fFU/UNgi6VrSTV3DtW7CLutNARdM+nHpm9lSntSdG0Bn/FXUfzbUllbRw2vrsoo46
	LeOdcpRIJQu3voxkVgalw08NYlIVEQLA5uqzhhvfjzsTXvLpcWNd5hRCRb2FObq3Ls1Qiz
	ig6+eecfEJQJO4Tagxf5hFG0OM62w58UA9/mKhNl0Pj5YhAU3DhFSzZb552UtUcgee23mm
	qY6BTBPdKIMVPJpLJDYDxy4bEXk1bv9cB8VTCFIKFv9Lif7VV3dGQeyvA0GPFrY14kZdwl
	ShfL7+/pebzXiowUuq3TvTjYNllyKSkDnHLCpxt1d1+1M9i9tCum1wS5Xb/akg==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
Date: Mon, 24 Feb 2025 10:58:17 +0100
Message-ID: <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -60
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehnihgtohhlrghsrdgsohhutghhihhnvghtsegtlhhiphdqohhsrdhorhhgnecuggftrfgrthhtvghrnhepteehfeetkeeujeethfehieelhfejfeduteejieelveegfeefieeuheeiteethfevnecukfhppeeltddrieefrddvgeeirddukeejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdeifedrvdegiedrudekjedphhgvlhhopegrrhgthhhlihhnuhigrddrpdhmrghilhhfrhhomhepnhhitgholhgrshdrsghouhgthhhinhgvthestghlihhpqdhoshdrohhrghdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgtshhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggrlhhishhtsegtohgurgdrtghsrdgtmhhurdgvughupdhrt
 ghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdgsohhutghhihhnvghtsehsshhirdhgohhuvhdrfhhrpdhrtghpthhtohepjhdrghhrrghnrgguohhssehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheptghlvghmvghnsheslhgrughishgthhdruggv
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Bound nsm_local_state sysctl writings between SYSCTL_ZERO
and SYSCTL_INT_MAX.

The proc_handler has thus been updated to proc_dointvec_minmax.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 fs/lockd/svc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 2c8eedc6c2cc9..984ab233af8b6 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -461,7 +461,9 @@ static const struct ctl_table nlm_sysctls[] = {
 		.data		= &nsm_local_state,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 };
 
-- 
2.48.1


