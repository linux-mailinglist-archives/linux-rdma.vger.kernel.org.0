Return-Path: <linux-rdma+bounces-16062-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL8BOoKVeGnmrAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16062-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:37:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8826492E5B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 11:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E745130054F3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF6341ADF;
	Tue, 27 Jan 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MOHJ9PIP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D7342160
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510272; cv=pass; b=tegoFw0mLzQIPWw8TstK7b+AAi36PPYZZr8rAFC8tmj7Wojt4JxgswQVJc6G3Nga3UxdRWXYUDXWg5Dd7b8OT6dNPa/g08LNBkiQmvRlyHZPG6Msh4Cno3o2EKDVB75KKfbkEADUe9QelBAWmYujTwVOGDax9+Elz47+L9oGCY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510272; c=relaxed/simple;
	bh=UtROhfLltHSHBFGP9KGZyJvXELQiXsiIDvuEMLFhDVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQnXIRRsvApQifV2wwIWv8Ue0C2sBxhEnHgzC2gQBO8A23eZr6n9SJIiQB4wJ1lxaOT4fclYkA0iOD4UEBOCYlCpJJFJ6GS/BfyEysYoZt9JQFI8LEXWmSE1VB0BJXIHOaOWEw8zQAA8+6aOFlHjpFdUurBtnFR24s8L4aVsmAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MOHJ9PIP; arc=pass smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-11f36012fb2so7726797c88.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510270; x=1770115070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deTw0ZQjjC9RYjHj4iPH/S2gDQyk2RDS0x6y8xWiit4=;
        b=M+LNIfeLidTB2HF1qJ1LGKWRuPEy/IZtkOpYsZlISfIX0sb0pmfhAMrbHvJi9v6Zob
         5CbYElt/lnIzi5ApeG1L+vDOc6QoaN0wWx3lO4oSsOepRA9l4qJ/r3mKuFuRTwnm4xTN
         h6p81puiTQQmIaZ/VUu69MdM0UndJvqr8vM8v9XCodHbl1rVY0wzO0WkxbguMPUOOU32
         xLLtCmf2Kw5Dhxl9ov/IH5O9LQSrg/UT6u6N1NeYCqnV9t/c8uLog0OkV/wkF1WMrjBH
         WnZNwV1ntzeSKb441HqmTTIplhsoF9lHcNPZvmXyURIGXBs3IUZ3CG3ansiC14e5l3hs
         LGag==
X-Forwarded-Encrypted: i=2; AJvYcCW977Wa7Ru4ZMwRFKSl7GLrY4GwPbkjoyjNj/hRfN62IFEYGFqWIErvQ5rSrLo6JjywCydTjhAHcyAT@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQu9Tx9O3PsNK1jMCRJfN3y/ByKCJA5LmDB8Skat/YV8rYnAf
	ArTIT12ckbHKl1htwAxv3m+aDK7ov5wRYlbfe6t6/umUyCbKV/fiETg0kfbA1pT4374gRxgyXyX
	JXORF04t/yqSAHWiBr7f0scRAqNNP4PdzlsStml3tjQqVGH+8N/uv+KN1keoI/MXM7p788FalMh
	OY/IKmqhUVriSPt0rCniXxR4lCclxSNS4QFvx8yspv2DDGqm4wUh0ox8xZnEjdH9pdXqjUh34Vu
	HN/OoQNEnDvMKEdQ5fMEzDrowsm
X-Gm-Gg: AZuq6aLqJPfrMKoYffAdrrCrVTDJx/hnBR4B94uph7QpxjJqAH5HBW5I1nYo2ZQZpzs
	SHb+Hqm7XhDczLmp7vzzahZ2LYW73WKsUULA285Mdc8sbiTP6MBLXtZ2CUhPRDXY1WeVBjNQuNC
	4dRGy+XN+y6pkKVZC8z5ffLPhB9Z69D+hfw8Pi6JgEnX87E8c2536avx6lpDsD6kJGGBmQ+RU4w
	upRwLAKCSa8OcKUWVdWnqLuhmnz13nl9TVn5C9wo5zXQdFV3RC76H/pL9spoCHE91iTyFqlR8Vz
	OoAfcB3uUxJjVOZ633joUGLl8IDnLf9x8jO0OXzAmTwPReSRt67a/g1anluUMUbpuHeqrBL8C1H
	ZinQ0vXvbXJfju+xMOwvNTLXvjgoKIm8/B3vyg2D3hbHVAyuT9FLZjCl+ggpScA7FKXGS/GYl/U
	pHzTkySbxwQ7Ibp1EdTBq4IcoV3z9vkjktMsflpQNo+FqE5lH2ZsfrL8wb
X-Received: by 2002:a05:7022:6609:b0:11b:c2fd:3960 with SMTP id a92af1059eb24-124a00b9d80mr563049c88.28.1769510269409;
        Tue, 27 Jan 2026 02:37:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1247d90dde2sm2554910c88.2.2026.01.27.02.37.48
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:37:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so5785148f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 02:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769510267; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3PFa7UIiW+pTqayofg3nYfBqA0rJcBSHv+8tyk2n94uowkSyuxpGLtbuOA1m2C0Jg
         gtLgyDm209kBIat2ikHRskVRQGaQzX2yMDQY5Kh+Ceb2DcNKRg7VHbJibkchHMqkhl0w
         jqOLw6l6WGcwXl9g9sj4Pq4JsoloLBDTW32X4J5aS+PSVyLvjbwzKuj3pL87a+gMB5NE
         nSTmGJkY5rW7pWWcdj5RTJ0Vr0/st8KOcOjg5ULKap6XCUuCQx7mTrCwLI1yRaKDm+gq
         KDiFpKhDSW/NHVN1scdYpNm8fXgYb8w5LxtXSQj3ViGL5eqjIybcIJH2mNALG5Np65/c
         m1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=deTw0ZQjjC9RYjHj4iPH/S2gDQyk2RDS0x6y8xWiit4=;
        fh=UnHV/mTCjwhHNJVHQS26W1oXzh2UfcoscEvrB93I0kc=;
        b=H41gtFE+ElEW+bVGQI/ja4Q6tlEVmFrZIOOW4csMbeel3b2KxUH91JqSWodZcSL5GI
         ddqfFzgQU4ltpFvj3pmgYgHx/FLDJr7Nk2jWVO2adk45oi+7RDSU49R1eIWBaV3JtUNv
         KJdAXce3SihbqQcZIkxqDzYlF74Lo4wf9OZQtsSmUsU5RQDTWzyBKmRiIaOupuZu45XA
         ilo/szTl6d+MYj6MSIQDcVZVBdcd55OGTiHgecmN1iDGIsnsQYZWohAAwLlRe4h0Ar81
         dFYIabs5l54erVlpybDA8rbSgO6i306m4/rW3WDJmc2HEquaAX5HglxNh9bE8YqpbJN0
         Q/TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769510267; x=1770115067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=deTw0ZQjjC9RYjHj4iPH/S2gDQyk2RDS0x6y8xWiit4=;
        b=MOHJ9PIPwaPWwnsd3Z4YNyGGdbETsEXCViK6hfjQpNTYYVBq4ubN6xLHre2CvD6FIM
         S/3nDYr0zdXu4ybnGa8uBdVpVwMeiLGbV0zLhe2AswyCAgeHmLl4jt40AT/uOIcO9TS3
         9mc3vQ9iA4tsahCA6Oy+Y4R9UnF/veNWC6AvM=
X-Forwarded-Encrypted: i=1; AJvYcCWwFXYtbYuuZaZCVAP42Ij0zsDjTWkx2JysvcIvmTYmi/BC06lkHT/3vzOuG1BDvYjAb5ik/vlEOuz6@vger.kernel.org
X-Received: by 2002:a05:6000:438a:b0:432:b951:ea00 with SMTP id ffacd0b85a97d-435dd1ce217mr1721172f8f.51.1769510267145;
        Tue, 27 Jan 2026 02:37:47 -0800 (PST)
X-Received: by 2002:a05:6000:438a:b0:432:b951:ea00 with SMTP id
 ffacd0b85a97d-435dd1ce217mr1721133f8f.51.1769510266576; Tue, 27 Jan 2026
 02:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com> <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw>
In-Reply-To: <k3mj4pl3ifyrva44z4bscpzwgmvctr2stgorixsj2xwtvi6sws@7miulfpsl2zw>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 27 Jan 2026 16:07:33 +0530
X-Gm-Features: AZwV_QjDJfjCSYQU0cQ-h_vTII26N031cWOpNznGXUn6GvCxaDhzYXtOFY4bKEA
Message-ID: <CAHHeUGVvCChBpRamYtNVzcON7qq8zb2D98odrOPFYs=r0TqmJQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
To: Jiri Pirko <jiri@resnulli.us>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ed180706495c3657"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16062-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim,nvidia.com:email,resnulli.us:email]
X-Rspamd-Queue-Id: 8826492E5B
X-Rspamd-Action: no action

--000000000000ed180706495c3657
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 4:05=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Jan 13, 2026 at 06:09:56PM +0100, sriharsha.basavapatna@broadcom.com=
 wrote:
> >The following Direct Verbs have been implemented, by enhancing the
> >driver specific udata in existing verbs.
> >
> >CQ Direct Verbs:
> >----------------
> >- CREATE_CQ:
> >  Create a CQ using the specified udata (struct bnxt_re_cq_req).
> >  The driver maps/pins the CQ user memory and registers it with the
> >  hardware.
> >
> >- DESTROY_CQ:
> >  Unmap the user memory and destroy the CQ.
>
> Perhaps I'm missing something, but why can't you use existing create cq
> with umem extension introduces by following commit:
>
> commit 1a40c362ae265ca4004f7373b34c22af6810f6cb
> Author: Michael Margolin <mrgolin@amazon.com>
> Date:   Tue Jul 8 20:23:06 2025 +0000
>
>     RDMA/uverbs: Add a common way to create CQ with umem
>
>     Add ioctl command attributes and a common handling for the option to
>     create CQs with memory buffers passed from userspace. When required
>     attributes are supplied, create umem and provide it for driver's use.
>     The extension enables creation of CQs on top of preallocated CPU
>     virtual or device memory buffers, by supplying VA or dmabuf fd, in a
>     common way.
>     Drivers can support this flow by initializing a new create_cq_umem fp
>     field in their ops struct, with a function that can handle the new
>     parameter.
>
>     Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>     Link: https://patch.msgid.link/20250708202308.24783-2-mrgolin@amazon.=
com
>     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>     Signed-off-by: Leon Romanovsky <leon@kernel.org>
>
>
> As a matter of fact I'm currently working on a similar extension to
> create qp using dma-buf. Here there is totally untested draft, but I
> think it provides a picture:
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 1174ab7da629..6b89883028b8 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2732,6 +2732,7 @@ void ib_set_device_ops(struct ib_device *dev, const=
 struct ib_device_ops *ops)
>         SET_DEVICE_OP(dev_ops, create_cq_umem);
>         SET_DEVICE_OP(dev_ops, create_flow);
>         SET_DEVICE_OP(dev_ops, create_qp);
> +       SET_DEVICE_OP(dev_ops, create_qp_umem);
>         SET_DEVICE_OP(dev_ops, create_rwq_ind_table);
>         SET_DEVICE_OP(dev_ops, create_srq);
>         SET_DEVICE_OP(dev_ops, create_user_ah);
> diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infi=
niband/core/uverbs_std_types_qp.c
> index be0730e8509e..218906875f4a 100644
> --- a/drivers/infiniband/core/uverbs_std_types_qp.c
> +++ b/drivers/infiniband/core/uverbs_std_types_qp.c
> @@ -79,6 +79,75 @@ static void set_caps(struct ib_qp_init_attr *attr,
>         }
>  }
>
> +static int get_qp_buffer_umem(struct ib_device *ib_dev,
> +                             struct uverbs_attr_bundle *attrs,
> +                             int va_attr, int len_attr,
> +                             int fd_attr, int offset_attr,
> +                             struct ib_umem **umem_out)
> +{
> +       struct ib_umem_dmabuf *umem_dmabuf;
> +       u64 buffer_va, buffer_length, buffer_offset;
> +       int buffer_fd;
> +       int ret;
> +
> +       *umem_out =3D NULL;
> +
> +       if (uverbs_attr_is_valid(attrs, va_attr)) {
> +               /* VA mode - use regular umem */
> +               ret =3D uverbs_copy_from(&buffer_va, attrs, va_attr);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D uverbs_copy_from(&buffer_length, attrs, len_attr)=
;
> +               if (ret)
> +                       return ret;
> +
> +               /* VA and FD are mutually exclusive */
> +               if (uverbs_attr_is_valid(attrs, fd_attr) ||
> +                   uverbs_attr_is_valid(attrs, offset_attr))
> +                       return -EINVAL;
> +
> +               *umem_out =3D ib_umem_get(ib_dev, buffer_va, buffer_lengt=
h,
> +                                       IB_ACCESS_LOCAL_WRITE);
> +               if (IS_ERR(*umem_out)) {
> +                       ret =3D PTR_ERR(*umem_out);
> +                       *umem_out =3D NULL;
> +                       return ret;
> +               }
> +       } else if (uverbs_attr_is_valid(attrs, fd_attr)) {
> +               /* Dmabuf mode */
> +               ret =3D uverbs_get_raw_fd(&buffer_fd, attrs, fd_attr);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D uverbs_copy_from(&buffer_offset, attrs, offset_at=
tr);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D uverbs_copy_from(&buffer_length, attrs, len_attr)=
;
> +               if (ret)
> +                       return ret;
> +
> +               /* FD and VA are mutually exclusive */
> +               if (uverbs_attr_is_valid(attrs, va_attr))
> +                       return -EINVAL;
> +
> +               umem_dmabuf =3D ib_umem_dmabuf_get_pinned(ib_dev, buffer_=
offset,
> +                                                      buffer_length, buf=
fer_fd,
> +                                                      IB_ACCESS_LOCAL_WR=
ITE);
> +               if (IS_ERR(umem_dmabuf))
> +                       return PTR_ERR(umem_dmabuf);
> +
> +               *umem_out =3D &umem_dmabuf->umem;
> +       } else if (uverbs_attr_is_valid(attrs, len_attr) ||
> +                  uverbs_attr_is_valid(attrs, offset_attr)) {
> +               /* Length or offset without VA/FD is invalid */
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
>         struct uverbs_attr_bundle *attrs)
>  {
> @@ -96,6 +165,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
>         struct ib_xrcd *xrcd =3D NULL;
>         struct ib_uobject *xrcd_uobj =3D NULL;
>         struct ib_device *device;
> +       struct ib_umem *sq_umem =3D NULL;
> +       struct ib_umem *rq_umem =3D NULL;
>         u64 user_handle;
>         int ret;
>
> @@ -248,11 +319,57 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
>         set_caps(&attr, &cap, true);
>         mutex_init(&obj->mcast_lock);
>
> -       qp =3D ib_create_qp_user(device, pd, &attr, &attrs->driver_udata,=
 obj,
> -                              KBUILD_MODNAME);
> -       if (IS_ERR(qp)) {
> -               ret =3D PTR_ERR(qp);
> +       /* Get SQ buffer umem (from VA or dmabuf FD) */
> +       ret =3D get_qp_buffer_umem(device, attrs,
> +                                UVERBS_ATTR_CREATE_QP_SQ_BUFFER_VA,
> +                                UVERBS_ATTR_CREATE_QP_SQ_BUFFER_LENGTH,
> +                                UVERBS_ATTR_CREATE_QP_SQ_BUFFER_FD,
> +                                UVERBS_ATTR_CREATE_QP_SQ_BUFFER_OFFSET,
> +                                &sq_umem);
> +       if (ret)
>                 goto err_put;
> +
> +       /* Get RQ buffer umem (from VA or dmabuf FD) */
> +       ret =3D get_qp_buffer_umem(device, attrs,
> +                                UVERBS_ATTR_CREATE_QP_RQ_BUFFER_VA,
> +                                UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
> +                                UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
> +                                UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
> +                                &rq_umem);
> +       if (ret)
> +               goto err_release_sq_umem;
> +
> +       /* Use umem-based creation if buffers are provided */
> +       if (sq_umem || rq_umem) {
> +               if (!device->ops.create_qp_umem) {
> +                       ret =3D -EOPNOTSUPP;
> +                       goto err_release_rq_umem;
> +               }
> +
> +               qp =3D rdma_zalloc_drv_obj(device, ib_qp);
> +               if (!qp) {
> +                       ret =3D -ENOMEM;
> +                       goto err_release_rq_umem;
> +               }
> +
> +               qp->device =3D device;
> +               qp->pd =3D pd;
> +               qp->uobject =3D obj;
> +               qp->real_qp =3D qp;
> +
> +               ret =3D device->ops.create_qp_umem(qp, &attr, sq_umem, rq=
_umem,
> +                                                attrs);
> +               if (ret) {
> +                       kfree(qp);
> +                       goto err_release_rq_umem;
> +               }
> +       } else {
> +               qp =3D ib_create_qp_user(device, pd, &attr, &attrs->drive=
r_udata,
> +                                      obj, KBUILD_MODNAME);
> +               if (IS_ERR(qp)) {
> +                       ret =3D PTR_ERR(qp);
> +                       goto err_put;
> +               }
>         }
>         ib_qp_usecnt_inc(qp);
>
> @@ -277,11 +394,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
>                              sizeof(qp->qp_num));
>
>         return ret;
> +
> +err_release_rq_umem:
> +       ib_umem_release(rq_umem);
> +err_release_sq_umem:
> +       ib_umem_release(sq_umem);
>  err_put:
>         if (obj->uevent.event_file)
>                 uverbs_uobject_put(&obj->uevent.event_file->uobj);
>         return ret;
> -};
> +}
>
>  DECLARE_UVERBS_NAMED_METHOD(
>         UVERBS_METHOD_QP_CREATE,
> @@ -340,6 +462,30 @@ DECLARE_UVERBS_NAMED_METHOD(
>         UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
>                            UVERBS_ATTR_TYPE(u32),
>                            UA_MANDATORY),
> +       /* SQ buffer attributes - use VA or FD, not both */
> +       UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_VA,
> +                          UVERBS_ATTR_TYPE(u64),
> +                          UA_OPTIONAL),
> +       UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_LENGTH,
> +                          UVERBS_ATTR_TYPE(u64),
> +                          UA_OPTIONAL),
> +       UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_FD,
> +                          UA_OPTIONAL),
> +       UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_SQ_BUFFER_OFFSET,
> +                          UVERBS_ATTR_TYPE(u64),
> +                          UA_OPTIONAL),
> +       /* RQ buffer attributes - use VA or FD, not both */
> +       UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_VA,
> +                          UVERBS_ATTR_TYPE(u64),
> +                          UA_OPTIONAL),
> +       UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
> +                          UVERBS_ATTR_TYPE(u64),
> +                          UA_OPTIONAL),
> +       UVERBS_ATTR_RAW_FD(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
> +                          UA_OPTIONAL),
> +       UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
> +                          UVERBS_ATTR_TYPE(u64),
> +                          UA_OPTIONAL),
>         UVERBS_ATTR_UHW());
>
>  static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6aad66bc5dd7..5f4db48a6bb9 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2503,6 +2503,10 @@ struct ib_device_ops {
>         int (*destroy_srq)(struct ib_srq *srq, struct ib_udata *udata);
>         int (*create_qp)(struct ib_qp *qp, struct ib_qp_init_attr *qp_ini=
t_attr,
>                          struct ib_udata *udata);
> +       int (*create_qp_umem)(struct ib_qp *qp,
> +                             struct ib_qp_init_attr *qp_init_attr,
> +                             struct ib_umem *sq_umem, struct ib_umem *rq=
_umem,
> +                             struct uverbs_attr_bundle *attrs);
>         int (*modify_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
>                          int qp_attr_mask, struct ib_udata *udata);
>         int (*query_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
> diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/i=
b_user_ioctl_cmds.h
> index de6f5a94f1e3..0eced4cafedb 100644
> --- a/include/uapi/rdma/ib_user_ioctl_cmds.h
> +++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
> @@ -151,6 +151,14 @@ enum uverbs_attrs_create_qp_cmd_attr_ids {
>         UVERBS_ATTR_CREATE_QP_EVENT_FD,
>         UVERBS_ATTR_CREATE_QP_RESP_CAP,
>         UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
> +       UVERBS_ATTR_CREATE_QP_SQ_BUFFER_VA,
> +       UVERBS_ATTR_CREATE_QP_SQ_BUFFER_LENGTH,
> +       UVERBS_ATTR_CREATE_QP_SQ_BUFFER_FD,
> +       UVERBS_ATTR_CREATE_QP_SQ_BUFFER_OFFSET,
> +       UVERBS_ATTR_CREATE_QP_RQ_BUFFER_VA,
> +       UVERBS_ATTR_CREATE_QP_RQ_BUFFER_LENGTH,
> +       UVERBS_ATTR_CREATE_QP_RQ_BUFFER_FD,
> +       UVERBS_ATTR_CREATE_QP_RQ_BUFFER_OFFSET,
>  };
>
>  enum uverbs_attrs_destroy_qp_cmd_attr_ids {
>
Thanks for sharing these changes, apart from a 1-line change needed in
the uverbs handler (+ qp->qp_type =3D attr.qp_type; without this
modify-qp fails), it works fine.
-Harsha

--000000000000ed180706495c3657
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCqDm5az+UCEQr3RfjmlFMrRW7CItfaKY/U
HtVrvRR9oTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjcx
MDM3NDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBjKrZqZJvVYklzFIlIgUExXSz7wx2rXVOTEz/sK/FKpqw+6Ffp0DiYSFq05pRkV104wW7i
VNAahtii5tFTt5n5A+RHkt71+TWJfVrIoStTG3YHBIqbKdY3JUmBKVeUyT9RMicLIheJ9F7JTzV2
m+TCbRbkGuloVDR/KZYodMKBKz+9fXftrQzKP8vP/irgf/4U6nvPB/nVP3/vISn8WcsBOLsKFnj0
FECI4lcukl8m0QTJeDs6oXQxFAuMVJunfHcV6YM1h5ANwU+nL2Re6scJVOyGXzXh48d23aahDKMr
ubIjybr18aTvjFPZas8E58a5zXPQNOg+AZwkG4VTnPHo
--000000000000ed180706495c3657--

