Return-Path: <linux-rdma+bounces-11594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C14AE6C24
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0437A500A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E212E1725;
	Tue, 24 Jun 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKEEbOIO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5122E11D3
	for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781491; cv=none; b=sFnsPmAYiMGmaZld3Q3c70VOQB59q5/HxIUY0Eld9nYlIELFmv6z8DbG4q8foEaToJ1Ova3T2nvh9RRywV4Fq3pBlooHCjKTkzBhA7vvsZg3hF5VURh7vqI2UYO1LTY3ZG9Uh7jfa9PJWtj5xO1kZ4h49BjspypBdncyO5KujR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781491; c=relaxed/simple;
	bh=rpyrgzPqYdwj0KtWllHYX+bkm3/xQH68qnPbDJoG8UA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nX+/lgn8kkKU3r7X6X0lZOPvV2Vsh8vZKW5eI47nTLY5nfnCKGxP1TZUeDIEUpJqdVji5QdqvcOc7uMlI+LwOaRZaN6BQAh/utDOdjtJaG19Zi6yu41BCw+RDUzVQUc1uIf7BhKPIhgPeF/GK5edWDJ6wTFp+k3/aTFUTxB0W2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKEEbOIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750781488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vAplsu0koS/gXiH5wLf6N4Z+Ah3uxNPhjuFlpZhWyo=;
	b=ZKEEbOIOwPsQ1COJK4izeq0afMW5YHHb6p/WfTEJrcJY/PkqjmEu3HwlClEBqzLIxe+0w8
	U4kqlQICQ7Wz8YjNtJgnGyhIPQQot1jh/mvQQ1lPJyI/Te47dg/VV2DgReN1jFRuMGju/f
	Ar6rgROyM3qhS6pIHfg5kjj+9uJhBHY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158--0m3aFNDOA6SvJZINWLvLQ-1; Tue, 24 Jun 2025 12:11:25 -0400
X-MC-Unique: -0m3aFNDOA6SvJZINWLvLQ-1
X-Mimecast-MFC-AGG-ID: -0m3aFNDOA6SvJZINWLvLQ_1750781485
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a44e608379so159972971cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 09:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781485; x=1751386285;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vAplsu0koS/gXiH5wLf6N4Z+Ah3uxNPhjuFlpZhWyo=;
        b=jzN6w2IWjwwKx7WJvpYFjawS9C8XqOJf3sin0EiUJFbHlt9+Uo05CXX6WznFWCN+8s
         p64Hed64uEplG5et5Y6iDtVUfU8QnjPYLKYEqOZ4YlVO6mPAP8+YKW6w+Hnhry3T7LHC
         4YO9bKLM9y1TUGjZIydfQFlYt441/GRt0TMHUK/wm77zd+Ehs7d36L4mCn23qRu9mX8W
         2U4dV5G4fthFh8/U8w9hmCQRG+82K5VW6BKAha9BpweebvlWUptJThO+8G7r6DcALqnO
         s8ykg9mPn8O4a0ZjwcLwGDuWJGZIPwHV7G25nkHMGELQRBvy8gwJn6HA9gS60Q0U5sRN
         sJIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+4npvo9i9v6dMyyovvPbR1hHKXuVHxbHH96OPTROfwBesqgEPDklaXL+ZOzh0zKt8IkaYstF6ccPe@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLU4wVLhuJL+IRA+hdiMZhi9jp/VQn5y3/4AyZjVRO9+flgJQ
	thhcZ8dnFFKI4XgyVUhJZSzsXJLLtYSp8XNsysi36U3Gr1KKapLCyF+IWPJoGCxPOZ0tft+0iFV
	YmTsfH3NBeb7xokAfvLOnb4SRL72ObVdMaHFYeQK6tel4tgS+c2JWs9WaDJO7M9I=
X-Gm-Gg: ASbGncv+H2TInS601O1cfWF/IzkQ0NwDky9ztctiONfjdmoLF798zkG6v+3rs9s9SI3
	WOyswJ5ATEvQQyPSuWVktHmVVFgOVFXkyOIBnRUOClFE+kY+7nWlBxvMVhp8xGjLX07nvsc11Cd
	JFROrX4JALR/XjbdZ/gEfj25olLIo0rU1SJJcXoOjdN8LFWe9duEeqv7/SYclro1JJKd8Evfg+1
	4ZEpLnx3AVpw/ocSOSsavAMmldr259G4mIMmIBcb0Vahq9RyfK2X1apfsXz3FNNzdqW8h1rFgpu
	Y7EOykmXi2tn3bfeyDZ8WGMi9Tc2Gfv7Kma0axNTIlAU0scN7QNYvKyPPT0J94K+fLVBIsU+8Jg
	BM5cTS9KQrQ9XHJdt
X-Received: by 2002:a05:6214:509c:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fd0a54dc0emr331829166d6.23.1750781484655;
        Tue, 24 Jun 2025 09:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwO+fys6xaB3QgCvBNDb3NtvnbriukxpK0WFjoLSLnIQz+mQojAEJiClWr0nrT4Mndrjbm/g==
X-Received: by 2002:a05:6214:509c:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fd0a54dc0emr331828566d6.23.1750781484146;
        Tue, 24 Jun 2025 09:11:24 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efaa9sm517427385a.58.2025.06.24.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:11:23 -0700 (PDT)
Message-ID: <487a4646387595383bf8ae24584c5b54ec6aa179.camel@redhat.com>
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
Date: Tue, 24 Jun 2025 12:11:22 -0400
In-Reply-To: <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
References: <20250623080326.48714-1-hch@lst.de>
	 <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-06-24 at 10:21 -0400, Laurence Oberman wrote:
> On Mon, 2025-06-23 at 10:02 +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series fixes a corruption when drivers using
> > virt_boundary_mask
> > set
> > a limited max_segment_size by accident, which Red Hat reported as
> > causing
> > data corruption with storvsc.  I did audit the tree and also found
> > that
> > this can affect SRP and iSER as well.
> > 
> > Note that I've dropped the Tested-by from Laurence because the
> > patch
> > changed very slightly from the last version.
> > 
> > Diffstat:
> >  infiniband/ulp/srp/ib_srp.c |    5 +++--
> >  scsi/hosts.c                |   20 +++++++++++++-------
> >  2 files changed, 16 insertions(+), 9 deletions(-)
> > 
> Grabbing latest and will test tomorrow and reply
> 
For the series looks good.
Same testing shows no corruptions on storvsc for the REDO so passed.
For SRP initiators generic testing done with fio and passed, unable to
test SRP LUNS with Oracle REDO at this time.

Here it is, enough reviewers already so just the testing
Patches were applied to a 9.6 kernel because I needed such a kernel for
Oracle compatiility.

tested-by: Laurence Oberman <oberman@redhat.com>




