Return-Path: <linux-rdma+bounces-9082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7CA77C59
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CDB1690E3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CA20371B;
	Tue,  1 Apr 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ps4yLqMJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25A4D8D1
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514802; cv=none; b=jNpp7r53Q20FYSQJ39thRKmtDrHMryv0PsfZX+l9OKWIdU6KJwWAV8QixvLjs0tXzCV76WFPlccBfXFoBmRflS/u8uzfQvyOI+uaaGH0e96YsWOpYMULa1AylJO5SqmW91dryejaq4F1AMDDsMZ+KB8bLQK3MFUAzClumLyKkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514802; c=relaxed/simple;
	bh=+p40wUrdv8mbmzYO0iV+aTNaD89153b2XG1MqVoeQfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj/Jiz2LOpb8tgeKgQreW62qhj5RY8PExkY86O3+2VXi3A+jLgRZxUQHfinkiOwbiWRFu7EHMLylhN1xpv4IxVPUPWrmz+QKNZfomFwD1xinZxoDpMG/Cak6e+xbqGjn6QWUW8z9NWEMicyoQRo5CkJ/DvHLd4rb5SGW8HnbYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ps4yLqMJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso57461186d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743514797; x=1744119597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZARpP8PIMrK3ZXZ+1GuXPj6eVo8SRwKcXsnLCZzO80=;
        b=Ps4yLqMJWXaA0fsR2lSYAeZPrkHXeZvbH4WNKeSoaiMkJGdLU+wGNIMfN5ApgpibGg
         etgD0AWICYRhW637S9k9QLqWWPGucGbz0MJWKpS90OTORJ/O7BvjCh9GnZszeQKxBBj0
         XvW9NfnGQjfRq1AtOzGctMsTqpVazMS2PoH4DSpYUAR5iA1do9A4+42v+Ivnj7LyBm8i
         yHVliWdzAGJHpWrwb1fr/TDpHA5ufCIDNH8+z/G91M/wJ9ZG0UtN+cvMrpUa3iX0CKoW
         nMzEVDjIM+JLMhd/uSy5cNFTC/KsnCmkSLX2Y1jVf0o/zx3Ccx9fhF4o0lR2Gh5+bGZJ
         UWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514797; x=1744119597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZARpP8PIMrK3ZXZ+1GuXPj6eVo8SRwKcXsnLCZzO80=;
        b=bXSUjhtRq9ruaw6djFzN2iaZjsBoWms4XZ9xv03SXW4k/lApzJ/76h7uESlRR3rHl9
         0XHbP61rd0EnVwQgQ2bj6K9cwy8eCC4SoFE3um+JuPJixPfXWheva30A0VmfDEBjb8EI
         VHzN+XTRNOlVB6bc2ps1Njp9A66HBw6Sy4Y/bzyHDXip534kG5NEmVn5TpSTMY2ovkLN
         Z3QFJOp2q+i6KfI9bAygCX1T2sChPVb2iOKvyScniB0y2GTWgfZFJiyMw6Mcox2T6h+G
         nHe8fpRTSa/NdQpsNZeyZCxSaXMwN9kY1fGXj9DVY6CJAqAxJt652Z7U6+rdwu/TNVYo
         3pBg==
X-Forwarded-Encrypted: i=1; AJvYcCUqfwmkkICCuFvXWtrSu33bxL6EN2Lz3JowfV7JAKkOEEQrJsQv+T9XuJwarTNIJH7uvCRSt2cDm/6U@vger.kernel.org
X-Gm-Message-State: AOJu0YydJ8IwlB5jAFWkL1G7qEar2ttCE8C/KHMAK8HN0jedALmB9zIK
	Dgh9yHwYcwFG+HkSoxjUDIfSimzJXMAY3FyNimgjHVpbqUDcd1wpE6l6uIf29PM=
X-Gm-Gg: ASbGncsBF1FRZdFpYdxQMGPuVYW6H7hpFkV0Zv7xKgwYVUVN+drC1diCupjoZOIFpjS
	wD3ffXf0G8rlfHSnLTeBDSd9cSX4xbr5+gfpkysC5QzvrCccDx6zNyGimzpp6BdDs62DxUy0HYq
	z2qvarS/JdlL0L8761yp8SZUIESbowtTcAieumLuwq9O2tK2zIm6qeC5yjgrUfNx8u8NDYD/oxC
	rtEkrfu7Bxh6tbQtaUqtUxJA3ATSEkEy2zwlDvWJ+NmIS0PoTIO/hag1gqvEJCK4RrOBUqdUugj
	6K4rq4M6r9j+dRx92kD60REJKzaP9PXIdtxL+pQ1iosj/zWH0c9xrcKaImtoJUq2Oxw9/OVNPVX
	m08k5Ux1WSW3q3UHyg1AzP4c=
X-Google-Smtp-Source: AGHT+IGz4wEm/TQpOC8eY3cAeO1oKnfJYNE703i4NGsXYL/O0h1PFBw31iv9jDodJQsEFI4v+oH0lw==
X-Received: by 2002:a05:6214:d47:b0:6e8:f464:c9a0 with SMTP id 6a1803df08f44-6eed5fd86a1mr223925016d6.13.1743514797339;
        Tue, 01 Apr 2025 06:39:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec965a3c8sm61822266d6.58.2025.04.01.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:39:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzbqO-00000001Kr5-0bET;
	Tue, 01 Apr 2025 10:39:56 -0300
Date: Tue, 1 Apr 2025 10:39:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com, jonathan.cameron@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250401133956.GC186258@ziepe.ca>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <6e8c05f4-c925-8466-9453-214555e8772d@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e8c05f4-c925-8466-9453-214555e8772d@hisilicon.com>

On Tue, Mar 18, 2025 at 11:23:57AM +0800, Junxian Huang wrote:
> Hi Leon and Jason. After discussions and analysis with our FW team,
> we've agreed that FW can stop HW to prevent HW UAF in most FW reset
> cases.
> 
> But there's still one case where FW cannot intervene when FW reset
> is triggered by watchdog due to FW crash, because it is completely
> passive for FW. So we still need these patches to prevent this
> unlikely but still possible HW UAF case. Is this series okay to be
> applied?

You need to have an architecture where there are clear rules about
when HW is allowed to access DMA memory and when it is not, then
implement accordingly. Most devices have a hard reset which is a
strong barrier preventing DMA from crossing it. You need something
similar.

For things like mbox failures/timeouts, a timeout means the SW cannot
assume the devices is no longer doing DMA. It would be appropriate to
immediately trigger the reset sequence, wait for it to reach the
barrier, then conclude and error the mbox.

This way this:

> > When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
> > to notify HW about the destruction. In this case, driver will still
> > free the resources, while HW may still access them, thus leading to
> > a UAF.

Changes "destruction fail" into a barrier that waits for the device to
be fenced and DMA to be halted before returning keeping the driver
life cycle together.

You want to avoid "destruction fail" paths that result in the device
continuing to function.

Jason

