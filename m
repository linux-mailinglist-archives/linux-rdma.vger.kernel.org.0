Return-Path: <linux-rdma+bounces-19525-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCkmLtgC62lsHQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19525-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 07:42:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341445A020
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 07:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40CE73013D69
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E9345738;
	Fri, 24 Apr 2026 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Lm/Az7wf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0081344D8E
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009303; cv=fail; b=D91OlozIB+8cRNPTxhe/14xoEqUslmFOoRgbK3a/qEUjwZzwV57i9JjkwsagtViBAiAefF1XxBI9wwVR02Q1xe+0vIpGLgSfQtnDgE8Vy1nt5jNdVkWGSWLJD78nln8PCsdPy2TKDJcs49Jf75t3dMDz7TU8be34QTTfo3/l2fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009303; c=relaxed/simple;
	bh=Q0GtZzioBAe1xOAjDbkhlrB1hPU4MmLixdCpyIV7MDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyQ9dKNV2nyH6iLp7RH8s97z5QLTCscK3l2/p+NjFsDy1uc5jTG/mkoH/uZghpOSJ/N7YS0af14phjtD14QdyNSpV5tUeLMfVJtpS2ElT2J4wE9H4T7c9jQa8StjMJKURFmKMVfTnQvCUMoTlFojgvAAJa32O1jwLEtmey0x2dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Lm/Az7wf; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NH91MN1489899
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9DPAzRc9hNFtKml/U1KgfOpti+rrtUBR6KtYeiX3hBQ=; b=Lm/Az7wf7xyF
	brokmQfLsNW68y66IP7SZ8nGC1KsXbutmXjSA8cmHA2Jk5qKrwkv66B6NLirRkP7
	QPJwKH1umKEEjOC/XCpEBPz8VR5HvrCHOhrvpKJ8eh9uddFh+K22h5l6zVDTktN7
	jLt8ikr16+iDaTHEYZBdj9EwQNQuPWk9M1lNVPnUjA9qvJyXuvqeoXu9WoHbWI9B
	L0t0VhbSUUEr2S6i4dfX70Bl57EMc2glo6cixMdYzAixPwMAfd/ptjPwyZbZODg2
	Ev/aMiLmg2rES2HuztP8JKZyiegA5AN6JmiDik/5gngMEQiS5J4atlbQWviM1YCu
	HCwba9g+jQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepb4hhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7de44ba64e7so2609822a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777009300; cv=none;
        d=google.com; s=arc-20240605;
        b=XJNrdMc/HGRsUEjx8jUVHIBgnLMyEMQNvjUWfSOVDouaBFdpL6zHV3iOya4BCaYBLW
         AQzucHtwu1LkOuaCVOqvSjjWPeJE84rclgig28oqeGVyJvHLVg40U0vBHRnVbtCFzhvT
         rUq8K5rlbVxSdIGwt/y28T5frb4Tf1fAIrOch7uqc+4Nn6l6dIkG705GUvAYlZidjdff
         27HI10SoJDq8S42fEVZTErGFH9qaQmLcESZKqeQ23UVAwlAUZslpPQjtm8/9NGX2t4AS
         6AXac21fLo4V9QbmErvPA9FBIZIC2PV5UAxzXJW80XsxXL/HCs9VT7c7HYsTNiXkngDx
         Nkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
        fh=7qquTNfAxcJ/PynY6UKyThxwvwydeIxctbNPFgm4ut4=;
        b=SZXJC1RGTqBWlpXCRWsnL9tzAXPfT2BFGuD2tSFHd0NFzvTTjYYQ+RpHgtSzzOO3fC
         PFMyHjf0VIY3l1NUWk7zxIdU2H9oX0+ulK/2F/wYEdoyX/JB2vG2Ln24c8UdtL7mx+xz
         3tfeRnqSUk64WtxwhkjksN9W/rP4fSsVluByx+DgUoemlkq+GbAECE+opwtU1gSdqLYE
         aM7p85IdcuN2IWnbMB7zHaTQC0TbM96aqEqBXKd0+hOnYmukO+FEmBtcUT19TWtyzz+Y
         R0FHzn9NHgy3TskdY0xIMIei6jOpQrW5f+5IWYWTxOyqB39o+6MWO3iv4U1LhpdPOewY
         2eWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009300; x=1777614100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
        b=AFWVk8yXnQNOqWMxGJc8ji1RMC4KANfH68Y0m+gOfDdOTTJqeVMDq6WjLu15cS/mny
         q2Wo1vErvrQzn+oAUbGCUxvwb8ma5viEoPAmiTygQpIJHXWDDfaoQVBWD/Z2fVc4HVKE
         fJXvBVfEUqu6/2owALkY5IeEwf3x2rHF45wQ9YkC50cTteSbJ3XrLVeKSZfhFEE5mVM3
         F8IP6D2Bnxuc6bMZ7yIOoydLyqPdvubVcgQHTAG6WDQq18ve3dUCEWAfkRWB61BvgilH
         386hev/QwChxuYbnRBSwyAxnJWwdDye+Ie4l8DdbEuPmTGIyak3ugw5NJgiIJJ42JJSP
         UJog==
X-Forwarded-Encrypted: i=1; AFNElJ/zynqd0ZHTcJCm+nyaEhEB1EAF4Dj5j6XMqNGa2lWrvyIm6Ta3Ih3LffoVpIrgZ2Hq9E5H8brlSMZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzKym5pWTwCNMj2KqSEHP8/pDe/yjTAXvfxGshZ7Fk9CPaITGZ0
	NgW6cJl6lUqq2dwJJuw35/iijG/ENbAqRzgSkRPdqjXOP61sywwIfRGQy+f6mtb33c/rwpOCLa5
	AYwtQ/6QKHfh2WccXFY6hhsX01FsxVQbar0qwOXsEwZcgvTV9xCmyFXBd7fFrgcxE605sqH/osf
	cqf5EBPENVo+jTKzP+2KU1YQgsi91ehq7VIlpy
X-Gm-Gg: AeBDiet8U3EPYANt71hmSIN4PgQuATtjQmkRfQcEumH506GNo+whjm5IzA2CzsGTa8i
	M1zshH/rzmS7GIgFZTyl0+tJWPqj8iwAo0vurVnCSRTJ87IyU3QU3FxEFP5LejCHUMMH/u1RrVp
	SAZBONjKSAvMUnUkaiognEZbYoReze7ZBVG/Wp1TZQ4CGMQIlV6mSEVW/0QJSOXYFwrc9hBtvmc
	v7lLaZSbKWIplCmafOCcJQzdoUxiuAd81RPz+Cr/pLhGOoAE0Q=
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id 46e09a7af769-7dcdd585530mr8104219a34.18.1777009299923;
        Thu, 23 Apr 2026 22:41:39 -0700 (PDT)
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7dcdd585530mr8104199a34.18.1777009299430; Thu, 23 Apr 2026
 22:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com> <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org> <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org> <20260423224626.GV3611611@ziepe.ca>
In-Reply-To: <20260423224626.GV3611611@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 23 Apr 2026 22:41:28 -0700
X-Gm-Features: AQROBzB7q1PXr8uzLTg3LU7rQ4HbjUzfZl_SYDl7pi8tYSw_JSwSgZ8wHqWD6es
Message-ID: <CAH3zFs3z5WPBygyk+ZZcDhZitj3+e3=sDsyE5ZmL2iwa=Cxykw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
        Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA0OCBTYWx0ZWRfX8rx9e4tbojQe
 Wj2VOvDIRwCP2YcSrEHUy7wq1siBbqBRu0oGAo9YEYqN6vkNHCSDrB+yVS1Iaa+a1PjJVKJHNhi
 iyiCA86I2tpYSGwQsF0g8ycvwGQm7DLkimtfgPK9n+OFoar8VAwMN4llrFUmTPhphS/Bhcq2mhC
 d/JTr3iXzcu3nKEUgg4re9wIpGyMGwhsEHn65ZwYyKuy+x3nBM+tu508BpsW+lCivArNoXk+6S+
 UbN9e08QmmsL2C2mbsKFgyzQbnY6HG7ApR/o+fV84/ldhF8/dNMs0+9o4eGTPEAVnz5mIKnPufQ
 jX0lwh04hGNlFhpuStPLoWSJ93XOT0dKPyAnR1TkaqmoEfEIfUwXsSinNsAw6Jjh+EVwZPwkV2l
 ZpDrL0Nlqaekrzn7RDje/9LjxoiTU8Low+onRK3th5uiXqzCpP2LdbCL37plt+Wf4FdTwpuYDaE
 RBl2+gg1C9kzPDhrSrQ==
X-Authority-Analysis: v=2.4 cv=B42JFutM c=1 sm=1 tr=0 ts=69eb0294 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=9jRdOu3wAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: 4mHOfoF5_G9RCLu5sYjSq6SvcE0t9Lry
X-Proofpoint-ORIG-GUID: 4mHOfoF5_G9RCLu5sYjSq6SvcE0t9Lry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 6341445A020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19525-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,mail.gmail.com:mid,ziepe.ca:email]

On Thu, Apr 23, 2026 at 3:46=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:
>
> > My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> > unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> > the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> > processing hint.  It would fdget() the dmabuf fd, validate it's a
> > dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> > find the matching vfio_pci_dma_buf via priv under memory_lock, and
> > stuff the provided TPH values into the object.  It would be left to the
> > user to sequence setting the TPH values on the dmabuf before the dmabuf
> > is consumed by the importer.
> >
> > Is that a more reasonable uAPI?  Thanks,
>
> Off hand I think it can work, with the proviso that if userspace uses
> the dmabuf before setting the tph the importer may ignore it. I don't
> think that is a problem in practice.
>
> Jason

Thanks Alex and Jason!

I agree that the separate feature sounds like a cleaner design and could av=
oid
the uAPI complications. For v2 I'll:
    - Leave VFIO_DEVICE_FEATURE_DMA_BUF unchanged,
    - Add VFIO_DEVICE_FEATURE_DMA_BUF_TPH as a SET-only feature that
      takes the dmabuf fd, steering tag, and processing hint,
    - Keep the dma_buf_ops.get_tph callback as-is.
and then the userspace sequence would become:
1. fd =3D VFIO_DEVICE_FEATURE_DMA_BUF  (create dmabuf, unchanged)
2. VFIO_DEVICE_FEATURE_DMA_BUF_TPH   (set TPH on fd)
3. pass fd to importer

Zhiping

