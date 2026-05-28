Return-Path: <linux-rdma+bounces-21414-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFgRJuPVF2qOSAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21414-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 07:42:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C25ECF48
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 07:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B75A53043988
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 05:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB11315D33;
	Thu, 28 May 2026 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bg3I3NDv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25EB14ABE
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946524; cv=fail; b=Ktgw+4yg9F59AVvCY0MFJJ7ofhe8iY2X5rH7VBftIkfPJ/8ySV7+uS3VpM1yFI0clFzSWfDB3duyjM8Dmml1RL4Pgwq1XtUO/bDs4uPclr2E9wv+pCSaNElH5FXvk9yw2yPu9x6CgWwULX2hAD0Q9PGOGKhiVhBh3cjzJoEWwBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946524; c=relaxed/simple;
	bh=EnANVMnjWO2e/TF4qUwEkpjdrKKtkAxRlIBS/3wsNFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pni6xC65thRQ/QfgtwGKX2TIleSBC5aO3W6WrhnHuCM+iAGVePxcE3sRix7/Z4uZ1/oi79YwQGKLmPZ47ejU+SiWTYo9cb5laeK3u7JFSMyEgTTanAvoTAqr1FCry/ALkwMZYJ01Y1lC1JfqFpOr9OWM6/RN5OGKOiiD49veU+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bg3I3NDv; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKj27I443603
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 22:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4PCAVqJEOIY16WjmmTqer3R+L0JDJr0Ts1ek/LWm3fc=; b=bg3I3NDvy6FE
	iPpy9G16MrgkS7tjdaK4pTBSzqZEYYkSr5lSf8zBn87x/6ztIBfNAOzJnXbkITnP
	VFaM/GIefnYWYt6TOhjePYUTwpWHC8tb9G94iars8MRPC0B3+3Bv1ehGIH2uF3r9
	X+cCM1mir88Ht7erbVTrSkMQLajLsqaX4Ka+CzlrYNI/+3xJEgpfsUb0R2FOT8oP
	C+oZphQuk8kWYB+GKsZEiR3QK1YcNTIkHoPt45gLIQZGmdCOi/qzknAC5w6RIfgQ
	ucUNMGl3JC8eLuPUn4MPOudkHIaVMon2NrKpJ0qR7sanUhqV/uTqc+2Jx6QeO705
	BV/ccfW4zw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1tcq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e666c30bdeso2511872a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946521; cv=none;
        d=google.com; s=arc-20240605;
        b=hurkqC/gPKov6NEKG19DgQore15b/PBU4YuaZd7jIA8fo4QXcAfmkdJCj4gfc8TcVs
         ZHmGboGXgMerZUG6GSsTIURTe24jptLjrFpudtwDx1A4WBywp2nAScppAuMUupoFtg88
         8lRNdgNs23b1ykqK0As5LqZOGSi3aBB9xvOBZNoezEwYaZqGb85WszUUcJid5TMX63M3
         dJPLPCSF0JQV7hXp3pCz08NPgxhWlEHMbvOv5aD4pisF6pcPG+wgRA7W0FjpxT6kXmUh
         x1r3FuG5TdmtnGUAXH3OgmvIIAzh0EwjiSvqtvqaVYU9PcFuf3WzmpT4mvGSRRzmk2Ip
         u3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        fh=PwGcLewC7I8IxbNG9ZaCpvtqQ5jNJiLuOSyY2SlsAV0=;
        b=TelRPIZUzhs4/Kf6v5W+eV+HGCfok4aXZpQTBMUkbAOEG3GfTxfI1zUXui90hMbaYL
         6jMA+vARk7YZMMKAzDyD5FSyI4P9pIF4HX6D30xjeY6z4NGRfhwtuYt7dOYO/OXBHFRj
         PviI23i7WiKtVjC+aWwCK/E55DqSA3Tdq6U4C7mZ1v0GDF2N7zH1kdA2+vJmoUUq6pEo
         3ZM6YI/vCHVnCK1H1H8p2uWUa3/+M/HpnlLvCKOiagYPny/azduSG80nFNfawZfmcVjk
         GfFwAAEZTivyzP2+Slk6CXOMOjfw1EJ6KX1KJRbKtiX7sM/Rr14JYnwOb6XQ4tRXONbs
         g8wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946521; x=1780551321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        b=QnST1rJ75Sn2NlyXTDP648ZW23/H8JuUZ9mH6EWuIcZmmLCMU4O+XTzn8tJ3XZy1xD
         72a/fP3Zik6YDrfKxIMLLlSU/p+PdQR7jL6Ng1KbEHWLTxhww0PFwHPTO5wgPUsl819p
         7uUJ3rV8NrY7xdnNC7XNToLL7RDXqRleMERLbOpol6MInNIpldEqKrt29CWvpNcDjyMB
         gfMT85gsOghGwyMQmOFThUHQonEGd3b53X5Z96yT8TzcRkEXynd3nOt3UVJ274jv1yt9
         JIx9Ls/vLKPhTOquBE2qJiGFxYMR4bAC6yYNQYIiFiQPEoyeXqwnvIVoZd5E7/LOWsRY
         zR+g==
X-Forwarded-Encrypted: i=1; AFNElJ8ROhPmoUcxhpksqyt0vfoe7ZN28rOinPPHxDd4SiyvWg1MRnKqvMyyIdP3Xw96MZ+923+rYFKUfrgH@vger.kernel.org
X-Gm-Message-State: AOJu0YxAo/uya1g9kdKWiIWa/np42yRWKQAre+YJzvn8S+zfMQyRQKzg
	Gl0ayjPuDlTLAdcg6sB2dkk/uZo6p2GlkB4Z0sVrQaGBD8GwoZYLB16QMSf5J3kwOmtWphylnYJ
	q5ykxcxox6FQnmfa+OqOorK2lRy/uAm4nwBIhE5pJjlZOWuqoV+aaJUg6g3WvpVmXuNM72Zo+r/
	doiprWlHzu2rRz01CElusNAzZrx7z3qzn4HALO
X-Gm-Gg: Acq92OEdz5Aiv+ojS+Gt1gqFGQSSST6hJCxUNnGwwjxa5wbwexpRN7yMM87+RzrAnn8
	fdg6lm/BoGV2kdR/0ADr4H338WOYUnsQxyu8d+gL/3ly8wn7ui5M96oypFKUbDLK35mmOa1+HuH
	eKf1/FMXRiAQoIB+QYVy4GaeD3Algnf1kL3XnswML9e2bI3IGMi/+hM08AxIT+iqXWJ9/p5ZgHd
	mL1uuMJr5BCKbka3P385dWtSVd7BclxLIqU2dKXU+gsoKzfDqc=
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id 46e09a7af769-7e5feeada60mr15174382a34.6.1779946521046;
        Wed, 27 May 2026 22:35:21 -0700 (PDT)
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id
 46e09a7af769-7e5feeada60mr15174366a34.6.1779946520637; Wed, 27 May 2026
 22:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
In-Reply-To: <20260527145332.30412ea4@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:35:09 -0700
X-Gm-Features: AVHnY4KV2jkBImuet_2z0_HzyoNlAKuwWC1jyQGu9hjYNIH-m9ItRdizP-UfkeA
Message-ID: <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=F4NnsKhN c=1 sm=1 tr=0 ts=6a17d419 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Yn1Yo9TDUEbBsc1NC8sA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: h2-ynJvUvZApTEyOZwo_Pm6DDUzkgrRe
X-Proofpoint-ORIG-GUID: h2-ynJvUvZApTEyOZwo_Pm6DDUzkgrRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MyBTYWx0ZWRfX5Pk6l4uqWrUl
 6pNAa3ZYF+/2JBRGl4yI9newc1nf8lHDuVHhhIQUwJu+CFgBOCPjXWtRAOWvo8iT/YzmLf8qgWM
 HJ2Ta84cdB3gTv8OLzJR7K9RHt8wSSI0c8h17IOOcGVAjcIJQ1JozDTSZi3KztrDcD9dfQuO97/
 zRN7afLMGbzk1Qh2Ze35xVbTBPbYXqXXua68gdcpsYWb7bcti9YxAYCXbN63sVWPxoSHyxns9fy
 XXM/qQehfc2hunq01en+KkcTEEUHlTN25dtati5Elb0ZfDRtO0k5XQFdOTvGQqIm0IvFoxfvxYS
 K42z4kFLdUlWnYrLJvuYwuarci5BhmAbaU8g9oAdkzjEQyFb2dMnGkoiY4/TP1nZSC1MD86ntqE
 lh3LNWBU1RItDfyzVO8q9JW9eXz2CAzKbJiQDxNN87Znc7I3YIjXW/wmKC+RqNnSHfHFfDA5mYD
 NaONcwBvpS4lxsE0IuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21414-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:email,meta.com:dkim,shazbot.org:email]
X-Rspamd-Queue-Id: F12C25ECF48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Tue, 26 May 2026 07:43:53 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
> > !CONFIG_PCIE_TPH stub for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/pci/tph.c       | 12 ++++++++++++
> >  include/linux/pci-tph.h |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d95..6c4492075ae9 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> >  }
> >  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >
> > +/**
> > + * pcie_tph_enabled_req_type - Return the device's enabled TPH request=
er type
> > + * @pdev: PCI device to query
> > + *
> > + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EX=
T_TPH.
> > + */
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> > +{
> > +     return pdev->tph_req_type;
> > +}
> > +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> > +
> >  /*
> >   * Return the size of ST table. If ST table is not in TPH Requester Ex=
tended
> >   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > index be68cd17f2f8..fe572737b409 100644
> > --- a/include/linux/pci-tph.h
> > +++ b/include/linux/pci-tph.h
> > @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >  #else
> >  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >                                       unsigned int index, u16 tag)
> > @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev =
*dev,
> >  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >  { return -EINVAL; }
> > +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { ret=
urn 0; }
>
> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> Alex
>
ack, will do.

Thanks,
Zhiping

