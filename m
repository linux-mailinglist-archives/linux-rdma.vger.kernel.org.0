Return-Path: <linux-rdma+bounces-12969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5337B38A2A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 21:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E545201CCC
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617C2D9EC5;
	Wed, 27 Aug 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTuWMCRX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2BC275AF9
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322503; cv=none; b=lSmTVYjLx8wnt5rMtaG0vCUNRTf+U8fc23Y4qg6d20zGzBNsYUJx/7BSOo4zXTO+q0pZXhcBH4v7Mvv0gcMffvq69SQqUWXu+UvwWIlOozlavor/PGa1xtUOAEAfEApbG1dZWs4LHaWJ9svBHBk3K+uZVFoKBsGMWDNjpzRq0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322503; c=relaxed/simple;
	bh=pFYzIhUVX6YNPj7n2kbXiWcOLASG3is3PTBekDrnkfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6wEcu+rIVj1hhk3zGrHU/1r+/S8z71qqYPmYQ9QhCP1XZTTZGxAoatvu+ddwL0Dpv0mFczVd0qFl2476ur0jdszefNDt9mlbnI80Y4zteeVYGZegKt2IFAjCECQmE8AGhB2YQSR1stRH40bLRypR22SvE+bKJs2eYyb3VfMaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTuWMCRX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f42459098so1134519e87.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756322500; x=1756927300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PnrjjSNjbB59nLsihxNen7P5eCcECxlksbGjr3QfSo4=;
        b=GTuWMCRXKQNdqBEZ/jzBATcmkiGX1EK3sc2iX6iMhA7l5BJp1SfYCLnOVwtc+xBMs7
         tYKzWZ1lrwuT7s+6w5TVkbHW+2EbvmFjEy0HW9pPhwBQWNfG5IdiT0L6h2IgB9xh4ePe
         SNalimcB1gB5InKioL9zIILOwFAqFGoVAoEjhef7Sa++fE1mdJSxp4/iCqJMgEWRNMzQ
         ye3yOmZVeUdlJwQ69xjDPj5GYckwqgCQaXT+/G5Nv1lqs9qp4iBiny6N16dMpVNV8LFG
         5IWsjXnWgn9IwmptlVNRGQiErEi+EozbardyoEle7Eo+YoGr5p6s2u8e98P5E2Sjd/O2
         rQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756322500; x=1756927300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnrjjSNjbB59nLsihxNen7P5eCcECxlksbGjr3QfSo4=;
        b=hrlv+JlQxC2CZ0lK+MeXYi8ssXbmurmixp0cBSrXh77SpIKS8gBFCGujTtJBBBCg2J
         X8lbuOPS6LHKbF6Nu/ySdMDwpH4GDHz9MszkrELCCW7sG8r7a3BiUAB6ivjuamJndnOS
         QTGLVoCq3AOZZCbz4u64w1tlYGmxfCcGKzN6RyT/Ifa2LxhNUXhuDhkOarRKsft4MHi+
         GWS0Komw0tMkymmZFDHraQt4/LnEh72/gSd+gil54QNw9CJr12/iLv3iveSYtQoLKPsO
         nIsW53Ns1nitxLmsxjD+nl8mjViDOb4e9R7RPvG4dtdnjPPkDgcps9tjBpPH01yETmRZ
         z6rA==
X-Forwarded-Encrypted: i=1; AJvYcCUSljBuE1xHUW8JfgpAbijX+vd8RtCz4ZRDhhtCjXHI2W/CdNcLoZffKdjVXtY3gci5oFB70bdF8bK5@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRnfCchV3oIZuEtw3XqLxIJwVPZgTVuF1UaRIeECXVUZ10XkE
	17iMlBOU8/ZL1FqB67BPI7DRwJmu5m5tMXF1CmOU+RMZ7KdcoQnYIrt6TrF2FUVBSKzZH8hOTM1
	lF3NEde8+X50hG9/NzDaGX8DoVH20tXoAQcqm9P0jBw4ZQ+jcfRiUDQTit5s=
X-Gm-Gg: ASbGnctHROeF4E0Z97oofdWqSw+wpn0UpjdjLO6jx4rbHvbQPKa0JyDfuKYPUd3J4lA
	R0QqdWWFdsDQqxKNKQrTK+FmDZPVxqNDsnaEhKUyXQiLHGlSAh6GlWA/ZZ4Mg8ytOeJiatvWU8D
	lJ4+VKhaYYvl+QdrxP5s5urLjDulM7L5VsKucjQ3fKGTalE7SslAVN4NC9RR8BZT3JXv2VB1uJi
	ofJXYaPDzS+Hvs=
X-Google-Smtp-Source: AGHT+IEWrGzffsttH4O+tib45b0wrIJ/d7AkLl4tRIUdxnNrwkJpoC10uYMJ0/l7MGaVN7vakQi2JHzw4CBGv8e0qQs=
X-Received: by 2002:a05:6512:631a:b0:55f:44e8:4741 with SMTP id
 2adb3069b0e04-55f4f4c6df3mr2076019e87.11.1756322499788; Wed, 27 Aug 2025
 12:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
In-Reply-To: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 27 Aug 2025 15:21:28 -0400
X-Gm-Features: Ac12FXwLwM1S7MNYi9Z_yeDcDjsDPkb1rDxu57rSIk6mkbJgjCsDmZ45ZnEi_Ak
Message-ID: <CAHYDg1Taj9PBoHRoNjBJsgmpWWYtkD9P5BHLRJ-BSi+4J6kU_w@mail.gmail.com>
Subject: Re: [for-next 00/16] Add RDMA support for Intel IPU E2000 in irdma
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org, 
	krzysztof.czurylo@intel.com
Content-Type: text/plain; charset="UTF-8"

Tested with rdma-unit-test (https://github.com/google/rdma-unit-test).

[==========] 522 tests from 43 test suites ran. (1872510 ms total)
[  PASSED  ] 481 tests.
[  SKIPPED ] 41 tests, listed below:

Tested-by: Jacob Moroni <jmoroni@google.com>

