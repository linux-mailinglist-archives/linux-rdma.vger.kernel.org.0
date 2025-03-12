Return-Path: <linux-rdma+bounces-8589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73315A5D6A3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 07:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C823A2FEE
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF47B1E5716;
	Wed, 12 Mar 2025 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNF4SDXo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11801CA9C
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762405; cv=none; b=WHuw1FPqIgWKaZ+jlNlvngWVllvRiUs9ERpWriwErGIF+/drYk2+WtbX3wncXCqV4eOV1YmU0BfH8YUiWBjdfAsZrCox8ZX9lvfs9dB78ZSaKX3twqD0k4rtYrmIsbrREiKXIDf6K5YW4XM173+06vRLsNegTSgudp0oKxnvmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762405; c=relaxed/simple;
	bh=IBuzeRwkqB6+F/12foTFAhWOL6qFrqLBoFqMqboKLsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F4cyJ5A4tZFcLHGWW8H/QBmYWMDReYa0QOekBefzK6ybUrUzSudDvrL0HTvVZ2OJQYMkq59t57wKlTuQaSMzzXGJD04H3IMMAw6wH3IKc95jr88uMpg+V4euDC0HZhZe51f5HgcFp1rKP1atLrmKqkBecfb5Y7GsLBMzfH2yve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FNF4SDXo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913fdd003bso256460f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 23:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741762402; x=1742367202; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHhCFga4OH4IwDoa+W4dHxdMy7DeqRb11bHdRiccL5U=;
        b=FNF4SDXoO7fMLm3IbbVy1ld9xtdNvG6SDhy7m+OOwYvRNv/KAJ1CSUbT3B/vesiXn9
         wgXc5IY4lafn/WO7LOjX4Bwr1jb5jJ1mRb05gXORzaMJtxtNMCXIwvB2CTfwH6wBxUXi
         HlQoBbwFx3yWybwU7shNWqzkFN0/Yj68rUMntZKYiFaInB0g25zfUATd5+ha+KFLZOR/
         WcE20YLgh+UqlPxsRIHUYudgRxIolAQiP46z7ktU4vJHO0BwaW6VB4CDN/EZafZMDM/o
         G1Z7CIPFj3ik7ipw4ftEYEKwmwpB1hAS7fr9PYaWzh/lrxEUmI5OtyP31A8AbPdiUPr9
         CtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762402; x=1742367202;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHhCFga4OH4IwDoa+W4dHxdMy7DeqRb11bHdRiccL5U=;
        b=MZer1J1wcGPdNlatyoEhPAnLuvSn/xsDPmR0wFtGXvtx6Td21rpwErLxY77cFXN8Mm
         4gRmBad1+inPFjFhlFKU+VW6hGuy2LK75OeOWbvShHodEae6hPTjlxq2I805CVKZYvcF
         RyQ7PxEB1S9EXHa/7S/bfMdsJY5Dt8gX5WJLu+6I7Wf0mggI7cLztsrEfmHONzMPhyRt
         eKM0ZMs+rdfxS8RsKIPNg2xj6UsVVi/ziuB2aFpWtYzv9VIT6iH6txMoXomlJSnY0eJm
         WYDVUQD56T94BYqP94W4LMLeuY2gUTZRFoC776k2+Q+k/tTHy/+yiohPbKd6KquBnici
         bzCA==
X-Gm-Message-State: AOJu0Yxaq/RJpwYSJxG79NksFI1SOMmLhWcndwzmy0PT+rRMsjbK8hxH
	wCXkRQXzHsYj/HSPhlmx7G+q2e19SbGS7U5PSv/mhC82bPs6RirSe1W30gLg/iQ=
X-Gm-Gg: ASbGncuOYGAb9qqH7AHO4I0Pd5xMm/epuL1eAMboPh3uimJKnJGUiFS0pqMcQu5ltCn
	CHkezFpCl96D1B4ZgCZ9CtxTkbouPiggkRW9ZrnOYYZj1QhD25FKtz7mnVZNGNWgq0lUfyBhWYg
	+WkCr3Xf8S+xTVym5nLriyc/qAczclrwOps6kCuAy75k6Pi5fgG6plzNAFXTSzgjhoFQGpOgPPO
	FBijnnQoLFrBQhEuiT76ZIM2N/ExIsxDN1kFBCYoxzvPE0+OXIOM67NWZpnQ1sofHluoOyWJ80K
	v6V8DzpUYnOrmCwVN/MYZnvVPYZEbEcEFraI57QkYXy/Vp39Jg==
X-Google-Smtp-Source: AGHT+IGBhgz72nyo+I0a6WZ7nDse4sU8maeIdOiuebi2zGvq0YU+C+8n8ETVW4KgPQrzFazNkR/ziQ==
X-Received: by 2002:a5d:5f49:0:b0:38d:b8fd:591f with SMTP id ffacd0b85a97d-3926bdf5b2cmr6282686f8f.5.1741762402006;
        Tue, 11 Mar 2025 23:53:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0a8d068esm11377795e9.33.2025.03.11.23.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:53:21 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:53:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chiara Meiohas <cmeiohas@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/uverbs: Introduce UCAP (User CAPabilities) API
Message-ID: <9f676f55-f5d7-4be5-88a5-4f1f5c5c997a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chiara Meiohas,

Commit 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities)
API") from Mar 6, 2025 (linux-next), leads to the following Smatch
static checker warning:

	drivers/infiniband/core/ucaps.c:209 ib_release_ucap()
	error: buffer overflow 'ucaps_list' 2 <= 2 (assuming for loop doesn't break)

drivers/infiniband/core/ucaps.c
    198 static void ib_release_ucap(struct kref *ref)
    199 {
    200         struct ib_ucap *ucap = container_of(ref, struct ib_ucap, ref);
    201         enum rdma_user_cap type;
    202 
    203         for (type = RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type++) {
    204                 if (ucaps_list[type] == ucap)
    205                         break;
    206         }
    207         WARN_ON(type == RDMA_UCAP_MAX);

This prints a warning if we're out of bounds, but it doesn't handle the
error.  This is called from kref_put() and with kref_put() this could
actually be done in a different thread with a delay from when
ib_remove_ucap() is called.  I wouldn't advise that for production systems
but it's supposed to work.

So this code makes me quite nervous.

    208 
--> 209         ucaps_list[type] = NULL;
    210         cdev_device_del(&ucap->cdev, &ucap->dev);
    211         put_device(&ucap->dev);
    212 }

regards,
dan carpenter

