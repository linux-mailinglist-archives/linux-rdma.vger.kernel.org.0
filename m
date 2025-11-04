Return-Path: <linux-rdma+bounces-14240-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C9C3119C
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 14:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB35B4EB90A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C72ED84A;
	Tue,  4 Nov 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CB3Qqnuz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E12EFDA1
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261206; cv=none; b=XY0ceLyOYwLq/CcvCTY/d9G9keh81q22WuPbzYo9UAY45k6FVm96Il/Q1qEMHgtya48NctPmxHIaBVIatw3zqnH6olOuon4kpRB0IMcaJ2X/fDkL8LNqgWIcoQrjE1zIlFhvAoyeEM2FAM0XryuirRHcPsd59Es8WtTO+HcJcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261206; c=relaxed/simple;
	bh=4+cPbc26eTg87r6oJopQT70VDMp9odHkuY0GoP6OCnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1HVF0Tf+q17jTfcjAiHK+bGQewd5OUxyztfvva0Rsq9EjWaVtTCGf0wqi1ILASkyRyO4qA832magiL0deKb6s/lYj5YM/rVVNEF3hOK+9ApKoaRaQCcqLDl1WxuFbrZQGzACBd3hi89xOI3rZCAcvUiKqH2zgi7T21aQccslTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CB3Qqnuz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88057f5d041so22487436d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 04 Nov 2025 05:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762261203; x=1762866003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5ZDuXhF3NhcH+qMj7Ygph/U6Fs8/ZJ52VUJPhLQzOk=;
        b=CB3QqnuzUnFNJt+5ok5wKg6dPtqze9Gm/B8y0FxDn/ZHSHR9Q+PJhKsV9kIvSsSZuS
         PS+OjylmJd/a5+EA1/cJlGo6/70rl0fs6SGXXXoAGIKNmSWVQDSzxXpA/qzOeufgnoe9
         SXqUogD0agKciHO7iWrs1KUQzcQK72Y6iWqfFg5gViXj0l8vmo5xlFdmWoieX6D8BFSx
         hFMdEAHxc46FDhOFUWz2sJF30WSw+FfM0Sd7WiDifzFQlaHtt++sIn92hc/R13R/ppu7
         ksNnZRh2z0E4fuUxGoNrdnO77GMaTYYL50y7briRPZRmPStPmOqgt/LzNIgMV+TLVptC
         Ujug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261203; x=1762866003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5ZDuXhF3NhcH+qMj7Ygph/U6Fs8/ZJ52VUJPhLQzOk=;
        b=B2utDT1eipX4Zd+EINQDrSDuWbVKIrLoPsQlBE53qbrwU2pVkdS9zHOhjpNlzGvsUJ
         IPLgdQUlMh5IhixrEpjZHDLhX1iPq3JG0K/A+7tA473oiiCczHIhvpbZ9lvECe/XwB10
         vkQpkgc89OBUtxYRQfP2n68Xnc953CH5AIkiabQTC7zU+eMeZAPeM+F03K/VXjky32y3
         V/esM2hmcFuq29FNbUsJSD4VhceHqO4Wv2dKPdAzo2HQcxYOVdDi/7CRTktKa+TndCfx
         GC0icA80pWDfhm50xu4kiqvI8FBrxLvMMs2vrahNhLUFNDc9Srg9Xfl3Mm6oOWYHiOP2
         3bdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC2U63J3W+ZJuCMKNu/au4102qCPSa0TaCD7TR+hreWl75ZQ7lx4Pae4de1slh3lOeFAUx6N/aJXn3@vger.kernel.org
X-Gm-Message-State: AOJu0YwqoK584ByM/nyFJg8M9r4JGSLtviIq3pJnT7HeWO0XjecngLYA
	qrCpXfpUuCxVb/tixoQYo6g3z6aTKeF2JnLFuBSvxzOrBHdO0CNYi3ntBdTL/krFX3s=
X-Gm-Gg: ASbGnctcum2UH5RFEmDZ2yrKLKwCYX5cWAQLOx03Qhri4e8N4cgGJPwwRvALVe0pS33
	nSmLxlcAbffk2+D/D8QMitkRO72HVdlddUASLzVRqqwXEQig5QPBuclEx5eSUdCakaApW60okrU
	qrZxxW6bv748fNzYgBSAaq+a7j3oAmsk9+zlspZA/wYHn4JsofXxFtMmI1LT3PLM5LF9/46nPQd
	idvz9DhMFbU1mWVbM4HD6RbgT6cbhxJ9p4PjPqCOdzjnUBVn6PcJ8o2HHFyvUsTQoAO3U1xkugU
	txJZ9j0Au5U/IHIjfcf3FJnuBNHEqoBd0VCgGVv0D6x7hvoEtarjOZG1iKvHaKUexOluBlr2Qyn
	gcJZIp7TKTcD54jPjEaHXhv5ErzDa1eQ6wStSHP7cElj3gTNI2cAQilD4DjXnpgg+mO6lOvQ8n7
	jaOU+ruioM/4usOwfNnvVN5qYZVN6380jaJL450AgjWbZcBA==
X-Google-Smtp-Source: AGHT+IEOlTc9oaA1x2AfRvPAJ6w1B+4RCq2EMB6Kyjai8qU12ysDDGOXz8qZlna1fR+S9ooK3h+FDA==
X-Received: by 2002:a05:6214:d85:b0:880:48c6:ad02 with SMTP id 6a1803df08f44-88048c6ae5dmr121169746d6.52.1762261202787;
        Tue, 04 Nov 2025 05:00:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060dd572fsm20682896d6.16.2025.11.04.05.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:00:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGGdl-00000006jtX-2vJW;
	Tue, 04 Nov 2025 09:00:01 -0400
Date: Tue, 4 Nov 2025 09:00:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next 1/1] RDMA/core: Fix WARNING in
 gid_table_release_one
Message-ID: <20251104130001.GI1204670@ziepe.ca>
References: <20251104020845.254870-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104020845.254870-1-yanjun.zhu@linux.dev>

On Mon, Nov 03, 2025 at 06:08:45PM -0800, Zhu Yanjun wrote:
> @@ -800,13 +800,24 @@ static void release_gid_table(struct ib_device *device,
>  		return;
>  
>  	for (i = 0; i < table->sz; i++) {
> +		int cnt = 200;
> +
>  		if (is_gid_entry_free(table->data_vec[i]))
>  			continue;
>  
> -		WARN_ONCE(true,
> -			  "GID entry ref leak for dev %s index %d ref=%u\n",
> +		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
> +			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
>  			  dev_name(&device->dev), i,
> -			  kref_read(&table->data_vec[i]->kref));
> +			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
> +
> +		while ((kref_read(&table->data_vec[i]->kref) > 0) && (cnt > 0)) {
> +			cnt--;
> +			msleep(10);
> +		}

Definately don't want to see this looping.

If it is waiting for the work queue then maybe this should flush the
work queue.

Something like this?

--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -799,7 +799,19 @@ static void release_gid_table(struct ib_device *device,
        if (!table)
                return;
 
+       mutex_lock(&table->lock);
        for (i = 0; i < table->sz; i++) {
+               if (is_gid_entry_free(table->data_vec[i]))
+                       continue;
+
+               /*
+                * The entry may be sitting in the WQ waiting for
+                * free_gid_work(), flush it to try to clean it.
+                */
+               mutex_unlock(&table->lock);
+               flush_workqueue(ib_wq);
+               mutex_lock(&table->lock);
+
                if (is_gid_entry_free(table->data_vec[i]))
                        continue;
 
@@ -808,6 +820,7 @@ static void release_gid_table(struct ib_device *device,
                          dev_name(&device->dev), i,
                          kref_read(&table->data_vec[i]->kref));
        }
+       mutex_unlock(&table->lock);
 
        mutex_destroy(&table->lock);
        kfree(table->data_vec);



