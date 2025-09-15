Return-Path: <linux-rdma+bounces-13360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F5EB5734F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 10:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275EC1A2075D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BC2ED848;
	Mon, 15 Sep 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a9kI7BVV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C320126A
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925876; cv=none; b=qrZZMcY1GrNlEcFNws1w4uxflSvSfR7NLGX2sSYL5qrMV9gXh3S7jSaS5UFwNFImvhT/MQ43QHJtGC6KKBxz4YhtfroCkT3RABKhHCwZ7ctm1FHNUjwOWv0LT1hk36ppfQke3oXycJxsH0jQKK/m62XSZ5agqXzX3jqbc0T8mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925876; c=relaxed/simple;
	bh=g11jWENkwoU8Na+ecvRfnbd5v+q98Q+5TPwd/Vvp8h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMMw7y1n3nHyzNJ3RG+7czkbtZWNQGfWMjedjB7zvkCW8QOxxzu2/ePPvKoZ4QymiPgyt0H0l1NEHBHMjZceUUaCGqbCo93TJwdRh0pz9s/htu6niCtmXoAdk8oDRjKD+qPEGqRtIKqPaWrp4VB1XueY83xXI4PkZ/0gPTzSZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a9kI7BVV; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4b38d4de61aso31695401cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 01:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925874; x=1758530674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQb8RYMYAzTXzTdmlJMr3dWkAPM5Utj+gm4PBU9wVqM=;
        b=jz2yrUaaZS12u+Db+ACScQY/vhbp+Y4j8ZOVEeQ+V9aaaQi1PTGE1QsawrSFkUgzSK
         +4ZBS6EbUVVqVbLeptMCasxePQgY3tk6M47IAA4drO6+YAvF9Em/pNiUE4Mde+vtIqw4
         PkQkx9rxrf709ywGeHhaIkrL+fXhAj0wdOODXM6/HxCuAYqneVS1tYlltzOwHeZnGcAE
         fv1cSZ4tsYjN/hM3yLHUIym0aqsyT7l1Cd7G3n1bnFcfppgbh/DvtrR3alNai3+StVpa
         wek4i4n771GZAPJxJb7XllAaK9rXCPgZGSNDl8b/NfpycTWBLsp/QB90c1z3e8H9K1zi
         w2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgl3TyS02crnvQkF7oF77e4nE+JSEW34JJZBFr3TZxZSXYE3qilPYV+cf+HxhjRIqvkoVHakL3FBJR@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBhpHxPN1gAg+6KLTTteX+4PXSX9ZttEELPsuHtPkwS5JoE87
	bE85KT+aEEtUQaj2DUJO6Ce92BpgRh9N/yReOyBBJyF9tMGLg5cJl0zkVeJ66BXHdEKmVeIh6K3
	OXydRSiUVcYKAuqbW5k0lJ8RLrMVAg5VqsfF3+PYVeGU/9Yj1EH+vZ1mLxu9zpwaATQyegUWnu2
	gFEdYVU+VX3x0weqyLFBBYaqyGVWALtx2sPvZ/KPDSU3/LcHIo2Nz4a/rAVpTa6YdpLPzOJIQ92
	ZTN0z3QI5JvdS4=
X-Gm-Gg: ASbGncs3VvGQ7krpOgG68A0xNHrd96umzoZsV8QomdculbCOZOWt8D0CV0+HrxDOYhB
	tiyG6oT4JwiUsMqoIpVedUs4mRwpybyZHXl6wQ7hfUplcSSc4ROUNQFloO01BJqUsHT0GQyCxDZ
	5xKxrX6+s3goLw5+29Q998j+QymdaNFDAK2bVzZaHi1bhDl2XKrUtV40RoooKx68tJKzRe6B3u2
	q3CTqyE8jziVWjeXTcmiCh9+jwuMDoU7nfEJtiLgH4BuWT98+4kaTYRGNP5q6Mq8hX8DEeI6Y+X
	r+Po2IcQHGWMJSj0ahz049balluDRlFD9DxVdZbKBMjg1oizajfUlkU7Bz9LXY4afNZcc38cHQs
	FIXKS4JR7Au/R584kca8VT5XS19W0PK3ULXVY+uJ/um9ukXv1KXOvpqk05DjIWa3qMZWZF3yjUN
	2+
X-Google-Smtp-Source: AGHT+IGra4qnEg7FaMU0Gz2vU3awDtjthTyn2D3wmCe29UtWahEJTyl/zOo2x4LiMo0ew4APDAHVYkEp4Nqc
X-Received: by 2002:ac8:5993:0:b0:4b4:989a:a272 with SMTP id d75a77b69052e-4b77d03e37dmr122117591cf.47.1757925873875;
        Mon, 15 Sep 2025 01:44:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-763b4518822sm9118816d6.17.2025.09.15.01.44.33
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:44:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32e0b001505so1523718a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757925872; x=1758530672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQb8RYMYAzTXzTdmlJMr3dWkAPM5Utj+gm4PBU9wVqM=;
        b=a9kI7BVVgIa316KWODzi4VXHNKcvd3yogQOE/9UP0mZ8mqsO4JxRpIrWXaOOCd5RTK
         /2nt+vuNsd8bt1uSSjxeGO/QVD7tAkq25v3jEuYteti3LVGZeiR5nIICME6f5mZ9158s
         zPzqTtKZ+OR4VY8HIhy3MLbPaxsS5FYOFV+BQ=
X-Forwarded-Encrypted: i=1; AJvYcCX/Ii0E5Og0OhlYPPageu6jv/cFXGcaa4dIi51gtED+fz6AaqXtLydn3QkHlzHKst/0tngLmCrPih0Z@vger.kernel.org
X-Received: by 2002:a17:90b:3a47:b0:32e:2059:ee83 with SMTP id 98e67ed59e1d1-32e2059f465mr6831683a91.7.1757925872454;
        Mon, 15 Sep 2025 01:44:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3a47:b0:32e:2059:ee83 with SMTP id
 98e67ed59e1d1-32e2059f465mr6831666a91.7.1757925872010; Mon, 15 Sep 2025
 01:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-6-siva.kallam@broadcom.com> <20250912083928.GS30363@horms.kernel.org>
In-Reply-To: <20250912083928.GS30363@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 15 Sep 2025 14:14:19 +0530
X-Gm-Features: Ac12FXw_V23dGUkYYORcZ7epnqiUhOp5KppY4fGCy2Xx8Nd4CLPLSNw62BORLqQ
Message-ID: <CAMet4B7SJXk1yMsJ61a026U3wNKr-7oNX9_-V+_W1PA0VRaaTQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] RDMA/bng_re: Add infrastructure for enabling Firmware channel
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, Sep 12, 2025 at 2:09=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Aug 29, 2025 at 12:30:39PM +0000, Siva Reddy Kallam wrote:
> > Add infrastructure for enabling Firmware channel.
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband=
/hw/bng_re/bng_fw.c
>
> ...
>
> > +/* function events */
> > +static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
> > +                                  struct creq_func_event *func_event)
> > +{
> > +     int rc;
> > +
> > +     switch (func_event->event) {
> > +     case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CQ_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_TQM_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCS_ERROR:
> > +             /* SRQ ctx error, call srq_handler??
> > +              * But there's no SRQ handle!
> > +              */
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCC_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_CFCM_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_TIM_ERROR:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST:
> > +             break;
> > +     case CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED:
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return rc;
>
> rc does not appear to be initialised in this function.
>
> Flagged by Clang 20.1.8 with -Wuninitialized

Thank you for the review. We will fix it in the next version of the patchse=
t.

>
> > +}
>
> ...
>
> > +int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
> > +                          int msix_vector,
> > +                          int cp_bar_reg_off)
> > +{
> > +     struct bng_re_cmdq_ctx *cmdq;
> > +     struct bng_re_creq_ctx *creq;
> > +     int rc;
> > +
> > +     cmdq =3D &rcfw->cmdq;
> > +     creq =3D &rcfw->creq;
>
> Conversely, creq is initialised here but otherwise unused in this functio=
n.
>
> Flagged by GCC 15.1.0 and Clang 20.1.8 with -Wunused-but-set-variable

Thank you for the review. We will fix it in the next version of the patchse=
t.

>
> > +
> > +     /* Assign defaults */
> > +     cmdq->seq_num =3D 0;
> > +     set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
> > +     init_waitqueue_head(&cmdq->waitq);
> > +
> > +     rc =3D bng_re_map_cmdq_mbox(rcfw);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bng_re_map_creq_db(rcfw, cp_bar_reg_off);
> > +     if (rc)
> > +             return rc;
> > +
> > +     rc =3D bng_re_rcfw_start_irq(rcfw, msix_vector, true);
> > +     if (rc) {
> > +             dev_err(&rcfw->pdev->dev,
> > +                     "Failed to request IRQ for CREQ rc =3D 0x%x\n", r=
c);
> > +             bng_re_disable_rcfw_channel(rcfw);
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...

