Return-Path: <linux-rdma+bounces-13367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0AB575A5
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BBC1AA0BFC
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E52FA0FD;
	Mon, 15 Sep 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U0keAOAv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B0258EED
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930962; cv=none; b=sro/6b8ub56R0DFcAoFZ/9Pv5nqvZ07FH4RHNNbY0SmhqQOwu+q2XkFMmBMwDjtsj6osl68wDRtp4nJRwqUCRkpAUnXAo0wR6WS+GhDXn/CDcM7o/5bLoabGXPBMzZ9NXUsExfsI1pYQsAnc4YKpf1kqc5HO6WO2YwtkqGQLy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930962; c=relaxed/simple;
	bh=U/PLbhhVuEXlMbLlMRHkNA9W3tLKTI+TRSl6kCsCOXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAEGKEiFSvu1CEt4sF3U2DKxMiClc12jZ7T018JMMCp/03tG4jSAXVCswR9A+C4aE0j3p/p1FEJ7/aOVFtYYg4c2iodWWyZAUPDAuxv18GFTymx4ghUlR4CyqQhpZhUqApMfEnJGAiYPjcfGAPQ7SDYZsq+UBGQybC8ZbJoyMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U0keAOAv; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-4240784860bso2622565ab.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 03:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930960; x=1758535760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBavr9jQ+h9BKvCBr1gL7d+lm7C+nGo8s+r9hY3b8xs=;
        b=MojmpISBcSpChhJ7hDsZ5NXaLLD2aQKkFpUmwUX++pKnClpqW3vdXYKOHaO5RqOYQ7
         mD5UQWrLuFTOiL5W2eg1bLICv089QJrRGSfCXy16o/T80Hr83r2G9xylXyveNXyQpBSJ
         uIcQnuZToWtVjVykjRUotXDBMCfWjwOwTFqTZ/vqEkuuiK8aUF9EvoKId5W4atmr6eNY
         KE4+Jw3PsSDvuSOi5HkPOicOTSalP3uV8v1jYnjnZDmXR+PbhTFxSumdmnpnrL5wQl75
         2+WCFBF6+Si1uPrnNY7t8qmvxsQTISYoCQMmQd3oP1b8c5/xuk2s1ejdMAKQUqmw4lKF
         JZeA==
X-Forwarded-Encrypted: i=1; AJvYcCUZyr5sDt6bR8ylpvP1jmAdu+sh9JM5xu2LJ6a199DOj7f5zI3n/SVXDKd2mQUY8V+CObovStxxS18A@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuAWdAPCJVMko902CFgH/0inrni6npicqO6UnMO1vbkq3T1uA
	6H5J2d3u7sGLBUHcO0bEJH2MB2FwEb0FGmi8dCeDEGLRIaq0dX5PLyUPI505DdKhhNFvn6LZXac
	diM9yO02lA3nKVWjTFoo3bgkLGt5RPbCp37sz8MWp8/z0pogScv8pO3U5Wdts9RXjUSLYI40mHr
	SjCuQ0WwhgFr4dhq7WDHww3f1bI/SlHU0Su6diPhwLTeyA6MNSW2gxzTv6I88RoKifF6JZYlT2A
	Lf+EFAgGlXbJ8M=
X-Gm-Gg: ASbGnctGYO8xTxmh994jp4rh3hQuaQmoubkmMkL1NekBgNPV3sOK1kYac/yda+OYuo4
	jJZQWxr5bOfm37my2MBxQf3u2nibHKX/aG5Eeg64R3ZVetv8oiTt3ybp0v0J0YAIR9YbHc8zkS1
	Mm4YFZ4c2i+7/1Jw6LWNqKOx95vxHioBilUdsOvnpk8UwXZV2Nxc44c6ahJU3l4hNm6m7fZ9if8
	LVO4yi6LD9o7weFNaCiO6uzEiKgukLIFUJvYhuFfZ52sdPd7RJHD7X/JDLQHL8eoOlhxr1g9Z9h
	VfcjFdBJaz3M92+XK2cR/zJ1F2mb0khVv/CO+zVxQHSGeRPyIYY66he1KpiisD9QYxUfWBWNQi7
	svJJX+vmHnKZp1LUkqoI+DUwTss3va4PbeY+m8q4DaBX3ZkuAH/stWtCDY7ap4V5+nukcm/SYfb
	rQ
X-Google-Smtp-Source: AGHT+IFzkFq7CNmp/WNVBOwUjYo7snmo3YXr772eWvMZgWa2oT1LagqSbwHWHYSQaHgNCOnBexlPhZwcEQp/
X-Received: by 2002:a05:6e02:19ce:b0:40c:6b06:be8b with SMTP id e9e14a558f8ab-420a3027132mr122629025ab.17.1757930959633;
        Mon, 15 Sep 2025 03:09:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42157aff9e5sm9100855ab.38.2025.09.15.03.09.19
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:09:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4e63a34f3fso2548271a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757930958; x=1758535758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBavr9jQ+h9BKvCBr1gL7d+lm7C+nGo8s+r9hY3b8xs=;
        b=U0keAOAvAmPPbBDQ7rypqEd4YWx0DFdS5eLesJ4u3X9rqpMAI1W6sA5v/VrrZd+Hm6
         TBNXCZeQtBlc8Ma+wgXfPKsowN44VV9Z9ORP7k9pEEpu6ctU5ir4jUlioUIBfsovBVB5
         vWtBZDrGtISQxwzcf1NzVK/76y+qIYwJFle8M=
X-Forwarded-Encrypted: i=1; AJvYcCUvIlDnLDyOKT9Fif6lIq42oP7opa5K6vM7BCJpfXGgZQTHOQJ67ciHCET0ymqwLiBSxl7PyA2NVOvy@vger.kernel.org
X-Received: by 2002:a05:6a20:7d8a:b0:243:cb7b:4f5f with SMTP id adf61e73a8af0-2602aa8540dmr15028009637.25.1757930958131;
        Mon, 15 Sep 2025 03:09:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d8a:b0:243:cb7b:4f5f with SMTP id
 adf61e73a8af0-2602aa8540dmr15027979637.25.1757930957686; Mon, 15 Sep 2025
 03:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-6-siva.kallam@broadcom.com> <20250912083928.GS30363@horms.kernel.org>
 <CAMet4B7SJXk1yMsJ61a026U3wNKr-7oNX9_-V+_W1PA0VRaaTQ@mail.gmail.com> <20250915090030.GB9353@unreal>
In-Reply-To: <20250915090030.GB9353@unreal>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 15 Sep 2025 15:39:04 +0530
X-Gm-Features: Ac12FXzj8nttMlLesrNI78MUsEI7XtM_elOMf9bmvak_fvi5RopheCYFXb7wkdE
Message-ID: <CAMet4B7oKv3wHJaXK-iFdbdtR30G5oYCz17TFQDYMLtrWH20bA@mail.gmail.com>
Subject: Re: [PATCH 5/8] RDMA/bng_re: Add infrastructure for enabling Firmware channel
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 15, 2025 at 2:31=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com>=
 wrote:
>
> On Mon, Sep 15, 2025 at 02:14:19PM +0530, Siva Reddy Kallam wrote:
> > On Fri, Sep 12, 2025 at 2:09=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > On Fri, Aug 29, 2025 at 12:30:39PM +0000, Siva Reddy Kallam wrote:
> > > > Add infrastructure for enabling Firmware channel.
> > > >
> > > > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > > > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> > >
> > > ...
> > >
> > > > diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infini=
band/hw/bng_re/bng_fw.c
> > >
> > > ...
> > >
> > > > +/* function events */
> > > > +static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
> > > > +                                  struct creq_func_event *func_eve=
nt)
> > > > +{
> > > > +     int rc;
> > > > +
> > > > +     switch (func_event->event) {
> > > > +     case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CQ_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_TQM_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCS_ERROR:
> > > > +             /* SRQ ctx error, call srq_handler??
> > > > +              * But there's no SRQ handle!
> > > > +              */
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCC_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_CFCM_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_TIM_ERROR:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST:
> > > > +             break;
> > > > +     case CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED:
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     return rc;
> > >
> > > rc does not appear to be initialised in this function.
> > >
> > > Flagged by Clang 20.1.8 with -Wuninitialized
> >
> > Thank you for the review. We will fix it in the next version of the pat=
chset.
>
> Once you are fixing it, please squeeze you switch-case to be something
> like that:
>
> switch (func_event->event) {
>      case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
>      case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
>      case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
>      ....
>         break;
>      default:
>         return -EINVAL;
>     }
>
> Thanks

Thanks Leon for the suggestion. Sure, We will fix it in the next
version of the patchset.



>
> >
> > >
> > > > +}
> > >
> > > ...
> > >
> > > > +int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
> > > > +                          int msix_vector,
> > > > +                          int cp_bar_reg_off)
> > > > +{
> > > > +     struct bng_re_cmdq_ctx *cmdq;
> > > > +     struct bng_re_creq_ctx *creq;
> > > > +     int rc;
> > > > +
> > > > +     cmdq =3D &rcfw->cmdq;
> > > > +     creq =3D &rcfw->creq;
> > >
> > > Conversely, creq is initialised here but otherwise unused in this fun=
ction.
> > >
> > > Flagged by GCC 15.1.0 and Clang 20.1.8 with -Wunused-but-set-variable
> >
> > Thank you for the review. We will fix it in the next version of the pat=
chset.
> >
> > >
> > > > +
> > > > +     /* Assign defaults */
> > > > +     cmdq->seq_num =3D 0;
> > > > +     set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
> > > > +     init_waitqueue_head(&cmdq->waitq);
> > > > +
> > > > +     rc =3D bng_re_map_cmdq_mbox(rcfw);
> > > > +     if (rc)
> > > > +             return rc;
> > > > +
> > > > +     rc =3D bng_re_map_creq_db(rcfw, cp_bar_reg_off);
> > > > +     if (rc)
> > > > +             return rc;
> > > > +
> > > > +     rc =3D bng_re_rcfw_start_irq(rcfw, msix_vector, true);
> > > > +     if (rc) {
> > > > +             dev_err(&rcfw->pdev->dev,
> > > > +                     "Failed to request IRQ for CREQ rc =3D 0x%x\n=
", rc);
> > > > +             bng_re_disable_rcfw_channel(rcfw);
> > > > +             return rc;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > ...
> >

