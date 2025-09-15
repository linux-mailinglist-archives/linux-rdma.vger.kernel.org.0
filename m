Return-Path: <linux-rdma+bounces-13361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02509B5735B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3CD17AB5B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE562EE294;
	Mon, 15 Sep 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="esTNBALg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368522D3212
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926025; cv=none; b=sjP4SMX7dY/sGeZz9CN+jLhhrWOSKqp11QDBnizlwOFdbQA2YQTdqlUFrDu7cyob0SHGX+vBsESvT8zdIuBntKDexeFwk2UNnVkkcua8bctqcnHMPEC2BI1ZZ2f3L7RF2WQtUn5JMeJ5anV3n4UphMZo+PVUhYxYcsCirv7EpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926025; c=relaxed/simple;
	bh=Nh1fmSS7S0Y+TlIauZOnptlFGVr7YB83chfdrVSrH20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBlQWqJQTRwSPc6Z6wN/d2sHhB0zKuTgcD+MxQT4mZEDUC2F6beA1aPkWCiPjZE6MZFGucG0981a0xm8g2UFukROFgcSkJsyhnfT7kbHU8eti8yh/61hy1Zy1I9G8Xanq4I72LfIes2pp5rwQj7852Gy1d6oBuL0CruzfxnAYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=esTNBALg; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-408929699eeso19064495ab.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 01:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926023; x=1758530823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRL/oERcgqujpEFqLS0DNlUVpNwIxOMmrM7SzRWb83w=;
        b=LFbK5hxIqyMseDVsYXmg4pB3Jtf64DEFceeubAmileG4IoF8kQPGg4MraystdDofVk
         uDQfTlNOca84rsIzot+dzSlt5RAffwZYCBCEcAMgyR04eom1FqDpUYSDlVjgmHikhe1/
         87qBS1EfGBJ8mEYeIWI9tZmJnMKYsJyPItPVwTDRX0Xx7mXoGvU6FFjpooaCjWYBcCoV
         HZpSPWjUDN/wjsFHbY5+eNnZQP32F4ke8S0hA3MvJ7t8Q6sWdcNAQlLxRVadyjthKVL/
         pL3xFuOuxOIVwraQHCzBgNB90mS+yXcBdWz+qStJBl1D5mqarNFf4mcpYZMh43KGpu4l
         5uuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2jU2bY6TO8CRU5wykk3mRi2Ey1viuW4MtGM4HVSPp9vjcut7udpl1AfrIL+RRUp5hIUCnIgfpmmbA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8HYjvVcr6H+inJi4oE6aGDMMatnCKei/mswf2KMAi8ikZrEp
	AYAe5RtA3Q2l0RDx5Sj6yIV6Gf+79oLMtlIZNpttCubTIE9BBgpoYzj5GLM6j5yvjYiIFiNoPcd
	W/YGfdSxGH2z8lNa5JBqLTmrTG4RFAQ2II/PqhTMLfVA8hdm6GkX3NQKiyb7I0fIoCnbD54Oh4z
	8BMEwl4pLlLXlYXPsIYCs2ZX7Q+BaNdpi5af2WzC1LY2b2nJjqtvvNoY3l+Bk3cJa0Zu1VxyQfA
	tEuF6XVlV5hpAg=
X-Gm-Gg: ASbGncvFA1UFRUfMc2guC38r9AlrSNuVHRBr6Al7dnGw48/6auVBDY8tEkqITIQPX1z
	mGhNceSryIqe5F0Tu5cDJMwYKhWZfYUVS92lRjAs3YoJQbYA0NmHguqXspYizkXbbB+crxqgMBX
	xn3i5KwmC9nJbvpoXxOpRn206C2dpVN2JY1eZ+GQ8pIuEQgaGTtt67KzOR9bGXJ/ECo4y2oP6n5
	Mj18EBPpUWSPHf7UGWqHu32DVmSuYAm98bQSLgGj2R+2ZbKS0lMgHqt9xNSKGJTfl8nLofIvW/g
	r0Jl3ZtgaevTWQWYTsNXus/ph5KlCfKSNNLKmI/XcrmhQk3mrGIedx5L8Gd+LdQ6EvxO8rJ4sYV
	lJyt/52i05lkjJE67d96uFSRfX9uKkXjpaKTaLvSuA68KZlgGOvH4OBrMfWq1QChNEQOibLufQw
	Dj
X-Google-Smtp-Source: AGHT+IGpitApu305d8rRSoGYDXovKe9mIiDpZ54cpyn9OBs2MYZa012Hms+M7SXiHl8X96wJt0ai6AhYpF2+
X-Received: by 2002:a92:cd8e:0:b0:420:f97:744c with SMTP id e9e14a558f8ab-4209e833e87mr143534325ab.12.1757926023172;
        Mon, 15 Sep 2025 01:47:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-511f304dd9asm925401173.41.2025.09.15.01.47.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:47:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32e120e0e4aso2395357a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757926022; x=1758530822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRL/oERcgqujpEFqLS0DNlUVpNwIxOMmrM7SzRWb83w=;
        b=esTNBALg0e8MiUaU+Q5gY9lAMDCrzaAA89qOxSNUD9puHmCD2Wri4ysyH8PvMSQDcU
         XLxtS/3XgayeTG6VBJ41OL8RHIQkthx7J3Z1608fxw9qcFEHICIuye2R7u0kY9wDIRf4
         jpTp8nRT8RD/sMuq9wHH4i2egdUnp/RdxFipM=
X-Forwarded-Encrypted: i=1; AJvYcCU2LoBJjjqNVyMqJVHzVqHzwfxc7ZYIty6QD7ln66XRsdFshmDtvYYkdBZIcbCx9p21NeNnZlfUZohQ@vger.kernel.org
X-Received: by 2002:a17:90b:390a:b0:32e:32e4:9773 with SMTP id 98e67ed59e1d1-32e32e4a039mr6276305a91.10.1757926021542;
        Mon, 15 Sep 2025 01:47:01 -0700 (PDT)
X-Received: by 2002:a17:90b:390a:b0:32e:32e4:9773 with SMTP id
 98e67ed59e1d1-32e32e4a039mr6276241a91.10.1757926020541; Mon, 15 Sep 2025
 01:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-7-siva.kallam@broadcom.com> <20250912084234.GT30363@horms.kernel.org>
In-Reply-To: <20250912084234.GT30363@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 15 Sep 2025 14:16:49 +0530
X-Gm-Features: Ac12FXxCwAvULClSZKcYwWuvMI0YbqfkcBpa1uDsHkgAnwASiLraUmmFYMFCC5A
Message-ID: <CAMet4B7PWUrZNnwVf+qdMVAA6L5Gw3sFEw6akNTWeq0X-HtdzQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] RDMA/bng_re: Enable Firmware channel and query device attributes
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, Sep 12, 2025 at 2:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Aug 29, 2025 at 12:30:40PM +0000, Siva Reddy Kallam wrote:
> > Enable Firmware channel and query device attributes
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_sp.c b/drivers/infiniband=
/hw/bng_re/bng_sp.c
>
> ...
>
> > +int bng_re_get_dev_attr(struct bng_re_rcfw *rcfw)
> > +{
> > +     struct bng_re_dev_attr *attr =3D rcfw->res->dattr;
> > +     struct creq_query_func_resp resp =3D {};
> > +     struct bng_re_cmdqmsg msg =3D {};
> > +     struct creq_query_func_resp_sb *sb;
> > +     struct bng_re_rcfw_sbuf sbuf;
> > +     struct bng_re_chip_ctx *cctx;
> > +     struct cmdq_query_func req =3D {};
> > +     u8 *tqm_alloc;
> > +     int i, rc;
> > +     u32 temp;
> > +
> > +     cctx =3D rcfw->res->cctx;
>
> Similar to my comment on an earlier patch in this series,
> cctx appears to be initialised but otherwise unused in this function.

Thank you for the review. We will fix it in the next version of the patchse=
t.

>
>
> > +     bng_re_rcfw_cmd_prep((struct cmdq_base *)&req,
> > +                          CMDQ_BASE_OPCODE_QUERY_FUNC,
> > +                          sizeof(req));
> > +
> > +     sbuf.size =3D ALIGN(sizeof(*sb), BNG_FW_CMDQE_UNITS);
> > +     sbuf.sb =3D dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
> > +                                  &sbuf.dma_addr, GFP_KERNEL);
> > +     if (!sbuf.sb)
> > +             return -ENOMEM;
> > +     sb =3D sbuf.sb;
> > +     req.resp_size =3D sbuf.size / BNG_FW_CMDQE_UNITS;
> > +     bng_re_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
> > +                         sizeof(resp), 0);
> > +     rc =3D bng_re_rcfw_send_message(rcfw, &msg);
> > +     if (rc)
> > +             goto bail;
> > +     /* Extract the context from the side buffer */
> > +     attr->max_qp =3D le32_to_cpu(sb->max_qp);
> > +     /* max_qp value reported by FW doesn't include the QP1 */
> > +     attr->max_qp +=3D 1;
> > +     attr->max_qp_rd_atom =3D
> > +             sb->max_qp_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
> > +             BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_rd_atom;
> > +     attr->max_qp_init_rd_atom =3D
> > +             sb->max_qp_init_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
> > +             BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_init_rd_atom;
> > +     attr->max_qp_wqes =3D le16_to_cpu(sb->max_qp_wr) - 1;
> > +
> > +     /* Adjust for max_qp_wqes for variable wqe */
> > +     attr->max_qp_wqes =3D min_t(u32, attr->max_qp_wqes, BNG_VAR_MAX_W=
QE - 1);
> > +
> > +     attr->max_qp_sges =3D min_t(u32, sb->max_sge_var_wqe, BNG_VAR_MAX=
_SGE);
> > +     attr->max_cq =3D le32_to_cpu(sb->max_cq);
> > +     attr->max_cq_wqes =3D le32_to_cpu(sb->max_cqe);
> > +     attr->max_cq_sges =3D attr->max_qp_sges;
> > +     attr->max_mr =3D le32_to_cpu(sb->max_mr);
> > +     attr->max_mw =3D le32_to_cpu(sb->max_mw);
> > +
> > +     attr->max_mr_size =3D le64_to_cpu(sb->max_mr_size);
> > +     attr->max_pd =3D 64 * 1024;
> > +     attr->max_raw_ethy_qp =3D le32_to_cpu(sb->max_raw_eth_qp);
> > +     attr->max_ah =3D le32_to_cpu(sb->max_ah);
> > +
> > +     attr->max_srq =3D le16_to_cpu(sb->max_srq);
> > +     attr->max_srq_wqes =3D le32_to_cpu(sb->max_srq_wr) - 1;
> > +     attr->max_srq_sges =3D sb->max_srq_sge;
> > +     attr->max_pkey =3D 1;
> > +     attr->max_inline_data =3D le32_to_cpu(sb->max_inline_data);
> > +     /*
> > +      * Read the max gid supported by HW.
> > +      * For each entry in HW  GID in HW table, we consume 2
> > +      * GID entries in the kernel GID table.  So max_gid reported
> > +      * to stack can be up to twice the value reported by the HW, up t=
o 256 gids.
> > +      */
> > +     attr->max_sgid =3D le32_to_cpu(sb->max_gid);
> > +     attr->max_sgid =3D min_t(u32, BNG_RE_NUM_GIDS_SUPPORTED, 2 * attr=
->max_sgid);
> > +     attr->dev_cap_flags =3D le16_to_cpu(sb->dev_cap_flags);
> > +     attr->dev_cap_flags2 =3D le16_to_cpu(sb->dev_cap_ext_flags_2);
> > +
> > +     if (_is_max_srq_ext_supported(attr->dev_cap_flags2))
> > +             attr->max_srq +=3D le16_to_cpu(sb->max_srq_ext);
> > +
> > +     bng_re_query_version(rcfw, attr->fw_ver);
> > +     for (i =3D 0; i < BNG_MAX_TQM_ALLOC_REQ / 4; i++) {
> > +             temp =3D le32_to_cpu(sb->tqm_alloc_reqs[i]);
> > +             tqm_alloc =3D (u8 *)&temp;
> > +             attr->tqm_alloc_reqs[i * 4] =3D *tqm_alloc;
> > +             attr->tqm_alloc_reqs[i * 4 + 1] =3D *(++tqm_alloc);
> > +             attr->tqm_alloc_reqs[i * 4 + 2] =3D *(++tqm_alloc);
> > +             attr->tqm_alloc_reqs[i * 4 + 3] =3D *(++tqm_alloc);
> > +     }
> > +
> > +     attr->max_dpi =3D le32_to_cpu(sb->max_dpi);
> > +     attr->is_atomic =3D bng_re_is_atomic_cap(rcfw);
> > +bail:
> > +     dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
> > +                       sbuf.sb, sbuf.dma_addr);
> > +     return rc;
> > +}
>
> ...

