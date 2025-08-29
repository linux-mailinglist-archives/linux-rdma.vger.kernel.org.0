Return-Path: <linux-rdma+bounces-12987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19E7B3B02E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7793F16429C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 01:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7821DDC2C;
	Fri, 29 Aug 2025 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3fVGpMg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1F1D5CDE;
	Fri, 29 Aug 2025 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429412; cv=none; b=PU+wfQZIBbehg+5XyJe8FBDoivdds1b6fDidpz/XPi19RLahvoV2u5+tX0HtjuKbnjvZrD0x5OckWNrmB+K9jRvxzNtajFDXHcgKxQKcoDLS45TQOFdg7xufDg/X5SO4Rv6jIetJmXGFaDoiK8qy0CSSNDT807BLHNjDbct2tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429412; c=relaxed/simple;
	bh=JnjTHc4tN+fj7bTEL4vaeVKqTaIJBWp8jzHXrTlqc6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCPJ5x8D6DtpuXrDCJXNUJiHKX20bOhxQsRxTwkL4SPrs+Z0kvNOD0IXTkuxBS3AxMGrx/zUAphxjn2+Gjkvqcd2arWST6qH6zko9+iIQQpNXYXZcjRTT/sAEluiwK34G2VwT3k6eN3L6vMZGcVI9qLsI3wf3Ko2HYAj928CPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3fVGpMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA38C4CEF9;
	Fri, 29 Aug 2025 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756429411;
	bh=JnjTHc4tN+fj7bTEL4vaeVKqTaIJBWp8jzHXrTlqc6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J3fVGpMgabd0xHSNkOU7/Glp23pcZHxo4B0/Z2eXh3M08w24rnhzn/kCh53F2efwy
	 qURAQZE9LKq4K2bioGolyZHbI+mj9FQ6imO1ZPCed42Vqn9bwzxVjOD0LjfhNTlM/6
	 hqj8QjsCmTcs60wgMTkmI3U4o16STA0luobBtNuGUpAl8XHyI1IBPSzPuSIqoopR3I
	 UtLbQYStZNzvVNLdjXtPKThSFW5vhQZSXYtJCgC9KAr4ndgNPDY6IkFftm+I2Pu0Fx
	 GKMZTQXsbZGGTaaYzxVXESYef+qIEBij+LhRT4MFGMTrWbp7dMDJdoJv7vro1DvkTE
	 4xREp4xA2h7NQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cf8280f02so1022710a12.0;
        Thu, 28 Aug 2025 18:03:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNz8NRvGb2julZ28XdTT27oUqxdchYzvqICy8YIQBL1NS+edCYZWqC7acLN2D70jXIPKyHXKQ7TjNL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs8XcSISZLwY5RZOc+Fl++dSyuXxCQPaY19sTuN2Z/NwC3SWV0
	E5Zavsv1GQQpDrtfSoZ+V2Gmrg7achFfvnMfVAxnwi48ASt0tJ8VrJL0hRgSc4mWEBH5eLNbpJb
	7eqDgWoVnK82cxNlCfVXb80YA2h3U1G0=
X-Google-Smtp-Source: AGHT+IEC3tzEBZVMFFl1IVXgtix0fY5IP99nyNrSk50T1sy3myoDXtbVpBcpWYLdNJsJljRKWhOMMIEUMhJmKMOqcvo=
X-Received: by 2002:a05:6402:5107:b0:61c:9970:a86a with SMTP id
 4fb4d7f45d1cf-61c9970ad16mr8655627a12.34.1756429409703; Thu, 28 Aug 2025
 18:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c6027ac-09dc-4ee6-ba82-4afd897dabf6@samba.org>
In-Reply-To: <8c6027ac-09dc-4ee6-ba82-4afd897dabf6@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 29 Aug 2025 10:03:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-TNCOd04Nw+FYhWT3inPCpQU0scT91FuM-SbahX3cRwQ@mail.gmail.com>
X-Gm-Features: Ac12FXwgjPnR8HAbaB9WFamRg7luu63RqUjZlEtl70_jCyn-9Os0DdZAWIdluog
Message-ID: <CAKYAXd-TNCOd04Nw+FYhWT3inPCpQU0scT91FuM-SbahX3cRwQ@mail.gmail.com>
Subject: Re: struct rdma_conn_param uses u8 for responder_resources,
 initiator_depth and private_data_len
To: Stefan Metzmacher <metze@samba.org>, Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	Samba Technical <samba-technical@lists.samba.org>, Tom Talpey <tom@talpey.com>, 
	Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:04=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Hi,
CC: Jason and Leon.
>
> this mail is triggered by the discussion in this thread on
> linux-cifs:
> https://lore.kernel.org/linux-cifs/f551bf7f-697a-4298-a62c-74da18992204@s=
amba.org/T/#t
>
> In include/rdma/rdma_cm.h we have this:
>
> struct rdma_conn_param {
>          const void *private_data;
>          u8 private_data_len;
>          u8 responder_resources;
>          u8 initiator_depth;
>          u8 flow_control;
>          u8 retry_count;         /* ignored when accepting */
>          u8 rnr_retry_count;
>          /* Fields below ignored if a QP is created on the rdma_cm_id. */
>          u8 srq;
>          u32 qp_num;
>          u32 qkey;
> };
>
> The iwarp MPA v2 negotiation can handle values up to
> 0x3fff for responder_resources and initiator_depth.
> And private_data_len can be 0xffff for MPA v1 and
> 0xffff - 4 for MPA v2.
>
> I just found that ROCE only supports u8 in the CM ConnectRequest
> (and I guess it's ROCE v1 and v2 as well as Infiniband,
> but I've only every seen ROCE v2 captures).
>
> BTW: does ROCE also support private data and if how much?
>
> So is it desired to limit iwarp to u8 values too?
>
> Thanks!
> metze

