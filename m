Return-Path: <linux-rdma+bounces-13433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2849B7F700
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AE0582E9C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F212DF707;
	Wed, 17 Sep 2025 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C/cyo+si"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C231BC58;
	Wed, 17 Sep 2025 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075403; cv=none; b=Yfp+7QAmwdKMxjbjVAj/hvTP+/NfKRNkz16i7cqLpzEgchpIuMu2uoAGnWBioUC85jr7m5/m9KEZM8ISnlvcGDyNaW2c9zS1e6FjH/oq5o/wrglCxdowQxYRUxGxVtX66RU6CuULJuvAl/DEh9PPsKyA0uV3nx5A/Y/mpsXS+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075403; c=relaxed/simple;
	bh=0h5IC4hB4vcqA1MeCKMaRQ1CQprih7AwfcGJEvlz36k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jx4jOf98TGmZOjdTm5v8yUJ8RRf5CfovvFpZccbWwcs/PZQ+/nFIu2erYmAmE6MTxdWm/oOSAz3ziJ2yKfyAWjRpQkdhkMljO4psrzfwpqgA9XudmyXZEqQr6CsZjGf1lyeKiIqWroYnWRTHJElAHXYmgfUibwExjfcfKsWIOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C/cyo+si; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=KZ
	FXUOv8rJmRZQ+Ct1Y4YDKVBMbWdMoJqlvmXvP+TQM=; b=C/cyo+siwlzLwRfQWy
	x2d83pBfLfdGZ3UUgRkqfjeG3SRdTlJAEBBBlxsTaPNNsGn5ywDTkKXOie1Xx761
	gyUeg6Ys0tBGXItPZqu5BhCPOr0zcNCmUirxwwSyXWkXV244KIoeWyiBNQ/5/gzB
	UN7P5BiGlN88Vh3KsBQu2ts78=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXf6fYGcpobBozBw--.62864S2;
	Wed, 17 Sep 2025 10:15:53 +0800 (CST)
From: YanLong Dai <dyl_wlc@163.com>
To: leon@kernel.org
Cc: daiyanlong@kylinos.cn,
	dyl_wlc@163.com,
	jgg@ziepe.ca,
	kalesh-anakkur.purayil@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH] drivers: fix the exception was not returned
Date: Wed, 17 Sep 2025 10:15:50 +0800
Message-ID: <20250917021550.47243-1-dyl_wlc@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916134915.GC82444@unreal>
References: <20250916134915.GC82444@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wDXf6fYGcpobBozBw--.62864S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy7Kw48tFWkur18AFyUAwb_yoW8Aw45pr
	4UW34qkrW5Jr4xCF4kZ3WUWw1ruFWftrW8J39IgFnxXw15Wwn3tF1SvwsIvF98GrZ3Gryv
	v3y5XrZxCay5uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUno7XUUUUU=
X-CM-SenderInfo: 5g1os4lof6il2tof0z/1tbiSArLImjKGIQmkgAAsh

On Tue, Sep 16, 2025 at 04:49:15PM +0300, Leon Romanovsky wrote:=0D
> On Tue, Sep 16, 2025 at 05:11:54PM +0800, YanLong Dai wrote:=0D
> > From: daiyanlong <daiyanlong@kylinos.cn>=0D
> > =0D
> > The return value rc of bnxt_qplib_destroy_qp is abnormal and no return=
=0D
> =0D
> And what is wrong with that? This is expected behavior - do not fail if=0D
> destroy fails.=0D
=0D
Thank you for the feedback! I understand your perspective that destroy oper=
ations should ideally complete cleanup whenever possible.=0D
=0D
However, while reviewing the related code, I noticed a consistency detail:=
=0D
In the bnxt_re_destroy_gsi_sqp() function within the same file (drivers/inf=
iniband/hw/bnxt_re/ib_verbs.c), the error handling for bnxt_qplib_destroy_q=
p() is different:=0D
=0D
static void bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)=0D
{=0D
    ...=0D
    rc =3D bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);=0D
    if (rc) {=0D
        ibdev_err(...);  // <- logs a warning here=0D
        goto fail;       // <- returns immediately without further cleanup=
=0D
    }=0D
    bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp); // <- cleans u=
p resources=0D
	=0D
fail:=0D
	return rc;=0D
}=0D
=0D
Whereas in the function addressed by the current patch:=0D
=0D
static int bnxt_re_destroy_qp(...)=0D
{=0D
    ...=0D
    rc =3D bnxt_qplib_destroy_qp(&qp->qplib_qp);=0D
	if (rc)=0D
		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");=0D
=0D
    // no check of rc, proceeds directly to cleanup=0D
    bnxt_qplib_free_qp_res(&qp->qplib_qp);=0D
}=0D
=0D
My consideration is:=0D
If bnxt_qplib_free_qp_res() is called after bnxt_qplib_destroy_qp() fails, =
could this potentially lead to =0D
=0D
This might be a minor robustness concern in the code. Of course, you as the=
 maintainer have the best understanding of the code context. If this is an =
intentional design decision, please feel free to disregard my suggestion.=0D
=0D
Thank you for your time!=0D
YanLong=0D


