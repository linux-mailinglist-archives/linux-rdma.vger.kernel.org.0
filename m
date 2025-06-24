Return-Path: <linux-rdma+bounces-11588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F990AE68B1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 16:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4871897076
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7498D2D4B55;
	Tue, 24 Jun 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2SS3SPn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1A291C09
	for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774904; cv=none; b=q/m7BcMUF40xCUjDTmfci1mu9pL0WVswqFx81QHsePlLO0MZR3896v+3XzXz5L/4RyWuIURVD0j/TkoxiOt67eXI237pYjkCtj0lP8qt+T/NnbpLjNTgKbSlcPppht762KwLltG80O047+fLCWpEC+jbCvjvv3yvT695x78QA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774904; c=relaxed/simple;
	bh=XwnGdWQkYlApWdZit8M7GQi5s2uWr0s+SHL5bLPxKSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNb0QSm4lEY6s5AcrHPDM2M9xYebx1F/NvaYzryr+uKN38uiU5lFUDdK9bJ+PcK4tC/lIolnPdHNeXXqemozbrgfWjyvTplisE5mRhJXTJD+U5ZzT6jLRDwNNQw3Xm4pJEjFZ6lh/LMuKATYcCa4q/fKziU0Q86rwWHnZQMXK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2SS3SPn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750774901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14xIxMy2YUHY1lgAeFKa78vWXvA9MuYA/3dz475p8Z8=;
	b=H2SS3SPnutJdbeEVJvjEeC83nwXo5Xonku8dRF970uqkM9MgKlICAGBsHz2lplocZ1dycD
	6DrZIG0ARg9GPBPOdiIqv4J1V6HgEOtMeD9V80XAqcNZzbS8pUzs6QCN01WA/sKejiTEPh
	BimO9kYfgu4nYdSOgkQ+a9hfsVrbGCA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-o67brosQNhee3AfQQM-nrw-1; Tue, 24 Jun 2025 10:21:40 -0400
X-MC-Unique: o67brosQNhee3AfQQM-nrw-1
X-Mimecast-MFC-AGG-ID: o67brosQNhee3AfQQM-nrw_1750774899
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d0981315c8so419624585a.0
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 07:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774899; x=1751379699;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14xIxMy2YUHY1lgAeFKa78vWXvA9MuYA/3dz475p8Z8=;
        b=fSxW66Ta1qPUDdr1VQpINQ/jvO6kyTPX7iGASyYsnEbaWOyoKFMk1rsYmYsK86j4/J
         Q/RIUqKC+hBPBXMVc1cIU6z21kuoUIiWmmtLF+5LN42gGA8E0f7pRAjbl7roqLtG5ivb
         KbkEobm0qubjzBhqxivwySkcH381sxaSxzjGbLEUaZrls4g9AlXAJwC1pUAFSyqJGHYH
         6DjcF49xINZUgh7Vno4PMcJ/baV1AuMwUYLtxF75dUqwBS5SwzLeJaLVm6pTm3aZC415
         4vhtBn4aFlKwUz0eqDLOvzxhn/t3beEiBzGobM02tqgR5NU1ufKmdFqjZUdCc5UJGEIt
         GOjg==
X-Forwarded-Encrypted: i=1; AJvYcCU/uoRwBZJeH8T0CjTQ4KtU7mFw/pXVDq4trlJEBU3yzNsiTLfGr4+FRlXIJSzcl0nlG1Yhdsck4Beo@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCKjK9z2rObdAKeSqsKH717DdoKgRaGLsV7cyFo79Evl8PgGh
	A5sDmgW7wk4UJJeEkJopNsKvArczp/ge5OQ0sgC7Ats9muYb4fomMrtOlW4UdQYvPqah3SpgOzg
	/Z4GUb6r3yeNwYTmLHfpuYYoQY5eNS9Fx6dxVqMDT0/LD2tuI/Zm4VTk0yqGgdjU=
X-Gm-Gg: ASbGncsMpZ3c9FDCv/t/9ft/ppCMSuyMUaOPGBUw/AiVreoYMMOMYUWaV6qzA+owl5p
	q9gRUyRzWfhylhcVT2AjUjOMjgXF9iAKkoxdFjN7IL7UL4X36UY5OkgiI16/CMsLjA2YuJxtFHZ
	Wla+/FeNrz+v5vgF5m7pRBLCqd7P1oNSUB0Xpwz2qWPIK+vHVDuvkWYvYhhCJ9yeEqfHXxZsprL
	5n1kqCx9azXfXJseDY+P2IfDswsVc73E09nA50z0fOWC1KnQMpJh2U63AHHhV181Ubwx0O4E/yl
	ZTS9gLMpRXECy6tvG2CEAXh4goXXz6o0wOvB1lDkUxxD+EM+vkHfe8Hp43duNJ7yGx6dzPofmW2
	RDN9JLxjNEJuKQU6r
X-Received: by 2002:a05:620a:410f:b0:7d3:c67f:7532 with SMTP id af79cd13be357-7d3f99327ccmr2313483185a.40.1750774899262;
        Tue, 24 Jun 2025 07:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR3cDql3VJLUr0EuiZIXkdr5u/svh4yWrVWPkzjWNmljf9JBpmaP0fofJOKq3rHI7yZwMwag==
X-Received: by 2002:a05:620a:410f:b0:7d3:c67f:7532 with SMTP id af79cd13be357-7d3f99327ccmr2313476085a.40.1750774898607;
        Tue, 24 Jun 2025 07:21:38 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99a6755sm504639885a.32.2025.06.24.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:21:37 -0700 (PDT)
Message-ID: <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
Subject: Re: fix virt_boundary_mask handling in SCSI
From: Laurence Oberman <loberman@redhat.com>
To: Christoph Hellwig <hch@lst.de>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>, 
	"K. Y. Srinivasan"
	 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	 <wei.liu@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Tue, 24 Jun 2025 10:21:36 -0400
In-Reply-To: <20250623080326.48714-1-hch@lst.de>
References: <20250623080326.48714-1-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-06-23 at 10:02 +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes a corruption when drivers using virt_boundary_mask
> set
> a limited max_segment_size by accident, which Red Hat reported as
> causing
> data corruption with storvsc.  I did audit the tree and also found
> that
> this can affect SRP and iSER as well.
> 
> Note that I've dropped the Tested-by from Laurence because the patch
> changed very slightly from the last version.
> 
> Diffstat:
>  infiniband/ulp/srp/ib_srp.c |    5 +++--
>  scsi/hosts.c                |   20 +++++++++++++-------
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
Grabbing latest and will test tomorrow and reply


