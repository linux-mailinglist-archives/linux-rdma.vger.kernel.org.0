Return-Path: <linux-rdma+bounces-20651-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sORgAP5mBWoZWAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20651-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:09:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CC353E34B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 08:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C13930432EF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB93C199E;
	Thu, 14 May 2026 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JrftBeB0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CCD372042
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738911; cv=fail; b=szEJRJUNQkg6ME6x6hZsyxwgwW6DNBiF7k82ZGWShyfEgX3Wpeq7RRenEDRPAvT1U74xGcXq54P+Sb6+emBUVKc2+qkSavqkRmb+xgGRVR8VBvESUsR+e52wADT8n4WP2JvGDhZsZozhSr78Yn+lh3ndvV0Kkamd3W7WLArT/kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738911; c=relaxed/simple;
	bh=e7Kow0xzJq1vBnIAbO87uy56Xrm9JYQWs9C9i1TFxY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqvckAIRQ/JTFIxvdwfEeEviZrd4QZnBQny/QLswL9Dm6d5kJJTPMynUz0ae3TkMpkfU5zXYLukAAKPlFOcx9fUMrE6JjfMScZBwfJKOg21HnYmx2q4MxbDf/3kjZIE+y+7vVb6hmC24EfnP0jQ480P9SWdlnDggXIi3IfkKVT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JrftBeB0; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E5glBm2450734
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 23:08:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CUfNd8j6o1cqzuTyhkUx5QHxT8WZBdIbLx1WShVD26M=; b=JrftBeB0hZ1C
	u9/4pXmowfTiMV+9zaUBxqBHL8hI/vpmgz/fqp2OwHpQGWU5Iv5WJSuD0h/uV0G3
	nO9ZfCV04i7VMuNq4iC0Z1ED4JixEmry8TU/qbL/XrDe2PsEhuSsIukh+RIEN9bh
	nV0Poj0YWnuvjK+vLJgr+PTTcO3Zj4DL2Inpyf51owJ38wz0vqrOVeKkoY+rrKs5
	5Gc2J1ZMzOeyrfN05Sx9NATUuLp043r/g5PF+Cw+RIQu07QEafML7+PihCQi57iq
	VTgj1pBLClgtpWkay28KW4QTF/U7SrPjIgKrANWPLw5YeiV3nX1HyefMpNbn1f4m
	XT9x5gQyWQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvnna29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 23:08:28 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dcde7bf859so14365670a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 23:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778738907; cv=none;
        d=google.com; s=arc-20240605;
        b=A8oowg5l7Q8rZGqgeZr/aG78wClSehOVuUphZZo1Dtwy2fDXsCHfsTxlQ6vCY9S3rB
         ljU5zBkuPPAJlWkoeYX+JGm0aB3MmiqzW4nrPKl2vIhwsXc2GolPGyDNOfvqHyJUgSYC
         yJoKYnapgE//I84bWAv3yjwjTP1bQN7BkQfKVKpdiiYyVicd9Mi3o54MU60kL/augVux
         Fng1k2MVmrzHNDRsHJQMdP+nlkHUWrHbQi/UBdMDXBwV/oQJgnPppUKolLh+bzjoEftK
         0/ixFVRrsRDCAf1Ms5nLWGe76eZ5FuxniA4nwa4BrUydlhMbksMTX4+Aqdp6vkVV4wr6
         +AKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=0KylqHwUi+PjJPZEIhBEmMw13oAHMDcoOl6huUe5x/c=;
        fh=GGoaA/g2kU5Ypkml2hzO7XOI63DnvrHIt+vdV2sME+o=;
        b=PeSlZmjZs+JZZEYwOI5+P3QH5Z8xhrNnL8FNAklP+bQSJ0YZRCdZib38x4udPsGWqM
         rsEKgv4vtOJQhrlKRe2Up8OD9dN5u5eX38l8mv1Jinw6Alzu70982pvC86HbBh0dw0Zb
         YYCbTAo1q9NWin5AAC+UDL5nh4y9aJoahtR6wj5CWAQGhekvfx0gqgDv4XaMjKEwhKH+
         vyGY3S3MqW1FP1CzcXQDL64ld2c1K6SiEy6nT6NyefQW6cJkJymv+9iCyHtx1jON7jRD
         6qabACaDNAl48OOxPOIYEDTH2t14rIQ52u4RbiG466qHwEptFaXk36zhvdOdDg/myILm
         kYUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778738907; x=1779343707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0KylqHwUi+PjJPZEIhBEmMw13oAHMDcoOl6huUe5x/c=;
        b=H1Dkee5lhP+inhWkRzvs+NMOjBHXOUj6nMXXUEKJDfGLAI7j0ckcSXw1Xay5AaYH0U
         veTQ9257ktpn2nMVdCAuWQql/YAigQLAxVcLcSrSiQtqBaeR8xcD0w3n1dX1T/HIiXQr
         iIE70hGZh19XgvohVaNJq+4fw2Qy25xYqFUe/ZS+DkZ6NtJ9eAOl1V8SA8PMkVQ3U8SO
         W/Stkv5sb9sksZvWvlJ8zCYdfkbSxl3Egh8CeSzWhWhy7PMuQ1JaovI5RT/4iUPWDkwK
         1U3xTkUAtofaFNPLmd5zbAwbGJZFrpA4+bYKD2xcY4N5mheRgOY12YGmluoa3ZeWMVY7
         U5OQ==
X-Forwarded-Encrypted: i=1; AFNElJ8f3DPDCEZ6OEYTP2/7HaW67ONeoWz32+He35/VGkzhT3TcVrpPagOz7MNAkSGEBCNC7dw8Rz+nwsqT@vger.kernel.org
X-Gm-Message-State: AOJu0YxObegrnRnIbUE659L6aLo2PafSfLEHCiK0TYcplNvL9CQ36+VA
	+6y5h2iMANy+5by2w1Vzc93mpwlvbk3EIHDOQKDWMGvNXtQ4e9iQadb0tX4t4mslFxo9qFNj3Kx
	a3ZDweEPO1FHoP6RnFTeF0B7vxGc+gykC/Q9uOk4rzeJ/EhqApfk0arLZkG3ud+Eng7i8MZJmJ8
	C5EKK9Iqv+ygohw2tC7NqXqHe4L7yngOnObAsf
X-Gm-Gg: Acq92OFwGTYqzBJsTvBBTG/h79wXK1e0Fx4UUonnUTm7bm/j8++36bjYtpmIEbrtquA
	7iYOHHLePA8f+pCIZSkOWmJtwiabguWDSFxwviWElvUnAadrlXURHPDkSfs/td1M3gp/r7jKerh
	5/DHacdm+wI+6sC9VGBYt0YXZPdmPtAoTaHvsH/R4i4eYh4aKiwy8z7oMpgdBRyE47S1tCNzOGL
	fD4Nfwga9cGYJrHHBvbI3pVF5HqbIAnsmY9ofVi
X-Received: by 2002:a05:6830:608a:b0:7dc:c301:d0b7 with SMTP id 46e09a7af769-7e3dcb27e85mr3708439a34.28.1778738907337;
        Wed, 13 May 2026 23:08:27 -0700 (PDT)
X-Received: by 2002:a05:6830:608a:b0:7dc:c301:d0b7 with SMTP id
 46e09a7af769-7e3dcb27e85mr3708421a34.28.1778738906835; Wed, 13 May 2026
 23:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512184755.4137227-1-zhipingz@meta.com> <20260512184755.4137227-2-zhipingz@meta.com>
 <e6928a10-77b1-4fdf-8bc3-cd0154b4d4c5@huawei.com>
In-Reply-To: <e6928a10-77b1-4fdf-8bc3-cd0154b4d4c5@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 13 May 2026 23:08:16 -0700
X-Gm-Features: AVHnY4Lk7AsZ1k9gNnGjrk1ylBU7xPjARj3UiyZ3EAOpFnNYqojJiXoPPS0-GYY
Message-ID: <CAH3zFs2W5cB5Jhk8pm9K=O3-DyN3tHm7h5q9Hu26ekV=_gBEvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: mxmvWqvnB7w3Ep8Mt4PiSX-RZOQN5U3d
X-Proofpoint-ORIG-GUID: mxmvWqvnB7w3Ep8Mt4PiSX-RZOQN5U3d
X-Authority-Analysis: v=2.4 cv=b/eCJNGx c=1 sm=1 tr=0 ts=6a0566dc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=eh8E65cc9O_vH5X4jusA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1OCBTYWx0ZWRfXx+PkdCeWEnAX
 MFznWsWct/Hj28xI9kM/PuKWPEA10IMniY8CEQXOSWQAOxoBkKv3dWG5IPpoz1tTPtGnRZKbrQG
 j+wS/XYSHFdGO7QAo+6yE0aomTcdSb8jhHIMO95aqhLCC3/94ARmunWaqA5z04dhGsBpmLaXoXb
 +Fq6qM4dMqMuCrqRYvjdhButYRlTeAJFH9Z0R6+yQ5CJCAtfOIcjrypg5ax4EhLVAoNSYSbFPCx
 133flXli1z/m7l9E7gV5mu/u6DncVW6A3gUK65XKJU7RueeLzmS4Pn1KD4lkvqI3NT5JPqcLyDj
 pbgBscUTnoIjKJylE/y3tH5K2HqKpKrWAHfLw9v/LouSdDL9Po8CGwEV00bNMnrWPeroDCA1I/y
 Mu+PzwgVAEZgzGmj+28pvMNr6SYUbnhPSJP7JKnlzDEarYykNpAq12w2HaPCMjIQj7yPifXOhP1
 uJkTfJxD7HSMp13LOoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 66CC353E34B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20651-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:email,meta.com:dkim,huawei.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 6:33=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> I have several suggestions:
>
> 1. In struct vfio_device_feature_dma_buf_tph, steering_tag is defined as
>    __u16, but PCIe TPH base steering tag is only 8-bit. We can use __u8
>    for steering_tag to shrink structure size and reduce reserved padding.
>
> 2. The flags field seems unnecessary. We can use value 0 of steering_tag
>    or steering_tag_ext to indicate the corresponding ST entry is not
>    available, which simplifies the uAPI design.
>
> 3. All TPH metadata fields (st, ext st, ph) fit within 32 bits. We can
>    wrap them into a union with atomic_t, then use atomic read/write
>    instead of memory_lock plus smp_load_acquire/smp_store_release. This
>    makes lockless access cleaner and avoids ordering maintenance.
>
> For details, see the text.
>

  Hi Feng,

  Thanks for the detailed review.

  1) Regular TPH uses an 8-bit ST, while Extended TPH uses a 16-bit ST, so
  so Extended TPH in Flit mode TLP can carry a 16-bit steering tag in
the request.

  2) I still think I need an explicit validity indication rather than using
  `0` to mean "not present". ST and Extended ST can coexist with
  different values (including the value 0).

   3) I also do not think packing the fields into `atomic_t` removes the ne=
ed
  for `memory_lock` here, because the write side still needs the lock for
  `priv->vdev` ownership/lifetime checks and the dma-buf list/cleanup
  paths. Open for discussion, though.

  Thanks,
  Zhiping




> On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > so peer devices can reuse the steering tag and processing hint
> > associated with a VFIO-exported buffer. Add a new
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > VFIO_DEVICE_FEATURE_DMA_BUF along with the TPH values, validates the fd
> > is a vfio-exported dma-buf belonging to this device, and stores the TPH
> > metadata under memory_lock. The existing VFIO_DEVICE_FEATURE_DMA_BUF
> > uAPI is unchanged.
> >
> > 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
> > ST table (firmware reports them as separate fields with separate
> > validity bits in the ACPI _DSM ST table), so the uAPI carries both
> > values along with a flags field that indicates which value(s) are
> > valid for this device. The exporter selects the value that matches the
> > importer's requested width and returns -EOPNOTSUPP if that width is
> > not present, instead of substituting a value across namespaces.
> >
> > Publish the TPH fields under memory_lock and gate readers on a
> > release/acquire on the flags field; this lets get_tph() run lockless
> > and avoids inverting the memory_lock -> dma_resv_lock ordering set up
> > by vfio_pci_dma_buf_move(). Convert the @revoked bitfield to a plain bo=
ol
> > so concurrent updates of @revoked (under dma_resv_lock) and the new TPH
> > fields (under memory_lock) cannot race on a shared bitfield byte.
>
> The commit log includes many implementation details, why not remove or si=
mply it.
>
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 113 ++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   |  11 +++
> >  include/linux/dma-buf.h            |  21 ++++++
> >  include/uapi/linux/vfio.h          |  35 +++++++++
> >  5 files changed, 182 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 3f8d093aacf8..94aa6dd95701 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index f87fd32e4a01..28247602e359 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,7 +19,23 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     /*
> > +      * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > +      * consumed by the @get_tph dma-buf callback.
> > +      *
> > +      * @tph_flags is the publish/consume gate: writers populate
> > +      * @steering_tag, @steering_tag_ext and @ph first, then store
> > +      * @tph_flags with smp_store_release(); readers do
> > +      * smp_load_acquire(&tph_flags) before accessing the value fields.
> > +      * @tph_flags =3D=3D 0 means "TPH not set". Writers serialize via
> > +      * vdev->memory_lock; readers are lockless to avoid AB-BA against
> > +      * the dma_resv_lock held by importers.
> > +      */
> > +     u32 tph_flags;
>
> As subsequent comments, can proceed without tph_flags
>
> > +     u16 steering_tag;
> > +     u16 steering_tag_ext;
> > +     u8 ph;
>
> struct dma_buf_tph {
>         union {
>                 atomic_t val;
>                 struct {
>                         u16 st_ext;
>                         u8 st;
>                         u8 ph;
>                 };
>         };
> };
> Set and get are done with atomic operation, no need for lock
>
> > +     bool revoked;
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +85,35 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
>
> ...
>
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @steering_tag: Returns the raw TPH steering tag for @st_width
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      * @st_width: Consumer's supported steering tag width in bits (8 =
or 16)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with=
 this
> > +      * DMA buffer for the requested steering-tag width. 8-bit ST and =
16-bit
> > +      * Extended ST are distinct namespaces in the PCIe TPH ST table, =
so the
> > +      * exporter must select the value that matches @st_width and must=
 not
> > +      * substitute one for the other.
> > +      *
> > +      * Return 0 on success, -EOPNOTSUPP if no metadata is available f=
or the
> > +      * requested width, or -EINVAL if @st_width is not 8 or 16.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> > +                    u8 st_width);
>
> how about rename steering_tag to st?
>
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..53b2bbd9fc1e 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) m=
etadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DM=
A_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) a=
re
> > + * distinct namespaces in the PCIe TPH ST table; userspace should popu=
late
> > + * the value(s) it has from the firmware ST table for this device and =
set
> > + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bit in @=
flags.
> > + * An importer requests a specific width and receives the matching val=
ue;
> > + * if the requested width is not present, the importer is told TPH is
> > + * unavailable for this dma-buf.
> > + *
> > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> > + *
> > + * The user must set TPH on the dma-buf before the importer consumes i=
t.
> > + *
> > + * Return: 0 on success, -errno on failure.
>
> -1 and errno is set on failure.
>
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)  /* steering_tag valid */
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)  /* steering_tag=
_ext valid */
>
> It could be represented by judge whether steering_tag/ext =3D=3D 0
>
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u16   steering_tag;
> > +     __u16   steering_tag_ext;
> > +     __u8    ph;
> > +     __u8    reserved[3];
>
> How about:
> struct vfio_device_feature_dma_buf_tph {
>         __s32   dmabuf_fd;
>         __u16   st_ext;
>         __u8    st;
>         __u8    ph;
> }
> If st_ext is not zero means it valid, and also with st field.
>
> Thanks
>
> > +};
> > +
> >  /* -------- API for Type1 VFIO IOMMU -------- */
> >
> >  /**
>

