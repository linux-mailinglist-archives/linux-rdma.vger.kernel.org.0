Return-Path: <linux-rdma+bounces-18401-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIvrHWkbvGkIsgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18401-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 16:51:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0042CE062
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 16:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1BD308C630
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AAF3E8C53;
	Thu, 19 Mar 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M0KzpPnh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC921ABC9
	for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935448; cv=pass; b=JV8OA2kKW1MJtuQEXHHaqdmKm1IoriWJruEEZU4V23FE733hxdo+ZbqlcOtqkn7BqOFDF0Efb/ys79IjcUDgX2ixWiIf9kK9tVQvjSUjtwXuHhRc5VlrGLyO151UaYUiGvDGEOzVRx+eKLPgjbNI6RJzldISugJRNiKAe86aA5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935448; c=relaxed/simple;
	bh=BDl+TAX2jsUieGPqNa9CCMG9QRFI7mpQ+r4kH7wMR4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CC1Y5iSy95KSJfZ0RvZRb9P+dkprsYyDg0TfqMofGD2pzH1orZvwREf8slH++opf8x4yf6hb9fhvqFbC/7b9jnDOv2VL+D+5V6RxNnYfWH/SZlQVkxxHE2WykJsPzFJVI1tfCcis2ReqmkwhSXdtwJhjToXy2cawFu8w6V5E+q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M0KzpPnh; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dea72099eso1972637e87.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 08:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935445; cv=none;
        d=google.com; s=arc-20240605;
        b=bywSLobQC1q+MTNwfa7C//QP9FgoS+8F5Ijp19RP4MKpYnq0QbcKHCK4f2XSjAPetm
         /5DUdtdgix+bwBCDIxjMsxfdNUE/MFRnyNbXVBgi8t2AOQb49Bhvggte9o5EstIP306r
         LsRCIl6HHLRFdsm1NYtN2ZplUoz89UXm6bRJ198/sE+GUygrsB+k0Uf1rzg0Zf6PSSlv
         FUyuhAE7mmpor1Yqbx3kPLUezIsCeB6Om1FBz00N3NQpWPBGV2HHqpKitKSjAeEZKBFz
         aWCVSwMXgSNaouS6OFrjwtTs1f+2CC3kaXqpernCtoJAckN/OgstyzG3LqwKV65NhswD
         e64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WzQJhTPZWT9fNEKrz3BJlDoK01RJjkbEy0Rn0xo2sLg=;
        fh=p+VmbVUq48P1bFwZ+S68MCWOCri6HhcVU8sVAkeU1to=;
        b=C0gOEWKRftCVsJDtkKl0PNcPrc4Fq9BPM/jPep5flwbNmTYSDigKS6f9nimDBheLmQ
         +ff/Zmw/ymu22PIQuF+hm84SneXY0rzjtt+5RqBYADgpqvVyIeaCCGBaFeeabBqH+ALf
         fBPlK1xLBrDJTehg4JAgpM549MiAvQeq73rP13q0FrA6e8c2Ceh/rqngaxRsSs7Nbthg
         CIEaht7QC6ajfVijap5jRiEYDCpXM5Lbdl0S4l/Wg7GPC3yFL8Jk9vm/arU3kjiAJymg
         xf/gnowrBLjcjwY4iVnv8vrmJ8cLqBGCO4jWwhVvBBjIXu35JvJL0P2KMGmndGXSCgNl
         jYdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773935445; x=1774540245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzQJhTPZWT9fNEKrz3BJlDoK01RJjkbEy0Rn0xo2sLg=;
        b=M0KzpPnhGG/pr1tyBgjtcaD5qGfmvdois8Dgnx/0XBks69KQLfk0jlJzlxaY05dxt6
         7GHm4D3UPl3+HTfuhfLfhWNyk8ezzndFBEO9QrXcPkuqwEt2lUjeqQfYP4vEaaDwqGkF
         L+wjDzDfvKsWkaIXnKVnOjcKd7VXReWaa/WviQCWiSQg+KtMVyDFBL1OPVfuCX0qvJlj
         G2VlBzmZ09lFj6Cbv/o9XY5y7Hs4dbcmQkpmNYruwEVwvQVwSfXrbvIfrS4WlsfLd1Nf
         F4dxAaWwoJaGbHfN9JDbd7qLiKut0Felz6WfpVfu+JLlyqeDtziiwWyuRK+66Vm9u70f
         Pzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935445; x=1774540245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WzQJhTPZWT9fNEKrz3BJlDoK01RJjkbEy0Rn0xo2sLg=;
        b=GRcUYts2Zf8CEIrpP85FbnQwuB4kdiDWXJMqxZwJTEDvvBGlPoCmgupoJqnWoZou5z
         6iltfQ/+/ZpCS6dYBciRwPAXrwFqCVT2Yg428IVscuLH0/xhR/cCX+k6JDaC43+lCCQw
         dL27JBZyorFSMBjRSWEaHhj09VrmlanT8zNj0YPlHQQuD0o4RT91D3WyA+SnW58DW1N4
         w4QUGlboAoTbTb4V1MinwTQ1pcsg7hdFGhKVYIpxxAO6SeY1x8cjfTQAf2cJjFEp+1rY
         OIPlgYTMlmILHPMsca6qFaYigf2nzGvAEMepZipKimPvZhG/XbLPUVRnGEmB+mng/nb/
         Huxw==
X-Forwarded-Encrypted: i=1; AJvYcCXebaM+GpB87EckjgwMU6nV+rrtjwtF9ypL24klaGTH3dRNPyaeUigpuN1KE50eWbUVKjQO9y62ru2t@vger.kernel.org
X-Gm-Message-State: AOJu0YyY51in/en9wP7RZLA0IURNvYl221r4ZETqPdm0sQw2/4GTYY81
	eveIt4ZJmeX8H5UnTr4/dfEDsPpm52UOKfpCv/scNw7QYrJbCCg0iw4cxyTMvNUJ9qkIaLFLM+e
	5/RboYdP1O1q12cVaDxuNRFjUP1bYPTeamWpYb79W/Q==
X-Gm-Gg: ATEYQzyJuN7z3xOjtRzCAgNN7umW9mOCO43I51Lwu05Ae6EAS73vr5LcqzeXciQHZHm
	1PnkBcxM87HTu9lgSkr7n9TPKDXcZVgeJ3ElFxfAwxnrSYbcvGJMOXAfepWt7L+ksvyHXkdKyUx
	iN9RCAKYCR1Hi3iCT8GfZOn8wDnKkFs/nr7IE2nxzvrZWrhs4+pHdaGMt1y1vNJE3PIXCOYulQ2
	oEQnEXXClPaNjaXsR3rS/D4vnHrw4QRLSFGqWTdQX6Lsu3UQVyT4L6AcjAJeBRpxBqzzN7kVWbe
	OoE3OIM2Lps4WQvzxGR+gjdkhbDbbEjrK/xtRIQG
X-Received: by 2002:a05:6512:1387:b0:5a2:836a:ca47 with SMTP id
 2adb3069b0e04-5a2836acba1mr667847e87.20.1773935445057; Thu, 19 Mar 2026
 08:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318152748.837388-1-marco.crivellari@suse.com> <177385760172.774155.8831510625996711948.b4-ty@kernel.org>
In-Reply-To: <177385760172.774155.8831510625996711948.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 19 Mar 2026 16:50:32 +0100
X-Gm-Features: AaiRm53VUt0XvsTCErI47gc45K1AoGa5ihSUssKoUNml3CDUbZC9otc_6NkpXYY
Message-ID: <CAAofZF4t-ynUkkTgdOWfDf+=dEOK5oe_AR+qi2gvmQY3qzXJCQ@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Replace use of system_unbound_wq with rxe_wq
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18401-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB0042CE062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 7:13=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> [...]
> Applied, thanks!
>
> [1/1] RDMA/rxe: Replace use of system_unbound_wq with rxe_wq
>       https://git.kernel.org/rdma/rdma/c/2102cbaf8db4ef

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer

