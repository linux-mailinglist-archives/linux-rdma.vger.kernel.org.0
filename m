Return-Path: <linux-rdma+bounces-7578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C6AA2D379
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 04:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2773AB953
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE31632CA;
	Sat,  8 Feb 2025 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gyu94s0l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6429D05
	for <linux-rdma@vger.kernel.org>; Sat,  8 Feb 2025 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738985066; cv=none; b=rMczzTLJQkdTck7LLn/3pdPoYU2urDspXQPlI9jcS4v8cxPbaWa933/6T18Fkov+ETF4jqjbAj0588NZZNpFHavunvyHWt82NMDHK2Ps3uYyoYtQ+wH2mjm/gicfns6Nzg01rF7hnq56wqOQgl2F/ieyCB3fQ4L+MBXhW9kn6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738985066; c=relaxed/simple;
	bh=Bg3OQ4u/q9PdnkN9l8oYbntB4/BsrRgui0pT0pdHJiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWF+wyQ6f5j7WBpemY2bMqPdZ3FUQIi3ukciUQfRx4CDLkv/2tLuCd/7YfZEl38j8uxik7GaK79xewfQvStK/jQ8hxNOBQdUu5HJiKUTvlmM45ZQ8wrHGbsLkcHJoAv7uPYbGJb8hNtJGi0y7I0fUXIEt+Yof9+nhcEot9g4V1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gyu94s0l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dc660b56cso1744879f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Feb 2025 19:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738985063; x=1739589863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg3OQ4u/q9PdnkN9l8oYbntB4/BsrRgui0pT0pdHJiw=;
        b=gyu94s0lDtuZU6i/Dr+NKi9y1y+EDMmkPnayRDvSYJ382yB4EAkVuaW+EQ4/Iiu8Wp
         9deJxvJhVe+bsfjC08bKP+zBNfME3TdzU5brq6qQ/l0UE0W4NdDVIpdlFqHX5Wc7IEri
         8/poeC1Ekj74tzO7OckjzDvfO05U/VtQzh56g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738985063; x=1739589863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg3OQ4u/q9PdnkN9l8oYbntB4/BsrRgui0pT0pdHJiw=;
        b=VWoZ02y8CzyLuESQV2yO1fgZU05Uf06teWnVLm6X5b54WZ+LY9fycpufpbgxjFH3Tp
         aNBqkhRsmZjUVurMGY7quOkYbMCE87Rrb2hr5qGQuGPP9BqV3FfqNDOBByl/j/c/bF5k
         lh1zbqX/3hG9ReLx/BCVw8NuB4UuWNs/JS9FJNS/GjbbefUYvVJtX+qxQWPsuXFdndl6
         QLoXYKb6w+JUBYb82NAsnwb0vKcqtqZr/NzPJA6jLowijlfzPt9Ew1K60RBoQ7LmeFni
         5kI2zIKPymO0aKc9CdztAP5AfIAlx96LbiJqRo89G2b2Jzi2vKMLBYOAX8IQ1yQjyGeW
         wu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2mA+/zYUcxlKsAnmRubfUECldOZgRypxIng2opWiLi3I6nhG2ibJoDXL0Gg+M/nL/mtWy6FwhSW2U@vger.kernel.org
X-Gm-Message-State: AOJu0YzISwAUawOe6UOdWYfNbuwggzdkN+712tvJlaNZfztCB8yD0G9v
	FlzHY3aZ/C22aJag8d7Jws9LVXMM+zP41FbSCoZv4MjUzbH3yrjbYFeeheAN2qxYeBCuLqYBDjY
	o1chXeR/Kn/7MSeJ7rYc2rlI3fpwSmeEKsU69
X-Gm-Gg: ASbGncuH24L2O3MtCg3OSqhpvWxVHA5+VTsUzke0R+gAtC0BPc6uOMMzSFvTgK0GdoG
	mhoo6Xol6QwjvkFgMZhha4BHsWg8u7dRtkq7u6EF+D5GRd1Tpfh4ZyLuQruufH6iHR7suTDGc
X-Google-Smtp-Source: AGHT+IHVNfL+UbPR8r6YIkIAeXWNEW4gOAC+ilgLwizDADgYX4kQ+BV2BsgCSdE/lvi9D1W/g2gdhuhfsZtya/2NQx4=
X-Received: by 2002:a05:6000:4021:b0:38d:c9da:d0d7 with SMTP id
 ffacd0b85a97d-38dc9dad258mr4248135f8f.2.1738985062707; Fri, 07 Feb 2025
 19:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com> <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org> <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org> <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org> <20250208011647.GH3660748@nvidia.com>
In-Reply-To: <20250208011647.GH3660748@nvidia.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Fri, 7 Feb 2025 22:24:11 -0500
X-Gm-Features: AWEUYZk3gk4vWfE5Xa1A63xy9j8Q_uI0hhFglszJkoyvnrcVpZjbm-6o_DTD9CY
Message-ID: <CACDg6nX-W7hzDUFMDmEtaZGUJu5dnSzcZpTXpn__O1kEu0ddRQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, 
	Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, "Nelson, Shannon" <shannon.nelson@amd.com>, 
	Michael Chan <michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:16=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
>
> > But if you agree the netdev doesn't need it seems like a fairly
> > straightforward way to unblock your progress.
>
> I'm trying to understand what you are suggesting here.
>
> We have many scenarios where mlx5_core spawns all kinds of different
> devices, including recovery cases where there is no networking at all
> and only fwctl. So we can't just discard the aux dev or mlx5_core
> triggered setup without breaking scenarios.
>
> However, you seem to be suggesting that netdev-only configurations (ie
> netdev loaded but no rdma loaded) should disable fwctl. Is that the
> case? All else would remain the same. It is very ugly but I could see
> a technical path to do it, and would consider it if that brings peace.
>

We can probably live with that as well if it's required to keep fwctl
in an RDMA driver and out of pure netdevs.

