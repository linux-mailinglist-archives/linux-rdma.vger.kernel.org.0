Return-Path: <linux-rdma+bounces-13412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56801B59772
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4AF16C19D
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3BE313E3C;
	Tue, 16 Sep 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioam/oqf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710A30DEC0
	for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028982; cv=none; b=i1+udqtYYFvlp1DUGAP4x9Vxfo6zSRW4Yl+BnIJDRxg85U6AWnnExWLTsIesS83gmTHQG1fgPgVPA46ACf4ZMRAMvBuvNOZD1L5CIXqUxuMIzIC2N4t15BKc4EaHesyJ3QyO/WHHt1ma3d52/2kp4siGA0hU43Nx3KBbTo6Su/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028982; c=relaxed/simple;
	bh=1IguQoOXA8FrFKBeUbtVgSy6pYqlTs5cyzQln/TF98I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jFIUYYrq7XzG60Ay9+xi3zoiy1+bZDj4wf/BYBSOcSUn+HycDnmee2JW2vTEAu7laUh90dMO2lf1H5LnAR0CIr7tEOANgpefwppQpf1iIdV5bkx8oTWjf9lRWz/agOFtYaodR7WJYdXtjbVU6e96kN4U2ijhouKsEIl/f+axTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioam/oqf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758028979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oP4iLXlqo17dgLSrgkQgZcHvE5Do89KtwinnL3mfgo=;
	b=ioam/oqfK9PWUJUcgXrzHoH2jakDC+YhJHx5ffPzIvhSaSCNv6RNjCgeyAoh3ZBG8K16te
	M02DRFvSou+EstuGZX/AnKpJ1s6Qx4yxxzuYHKPzXiqq/+3WKjm8/Ch9Nm6wDazcdoBCzO
	hAarNXM9nMgRYnmKAnMbYEs/aNYd58w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-PqFPAfPDOCWxHD8-tc-6pQ-1; Tue, 16 Sep 2025 09:22:58 -0400
X-MC-Unique: PqFPAfPDOCWxHD8-tc-6pQ-1
X-Mimecast-MFC-AGG-ID: PqFPAfPDOCWxHD8-tc-6pQ_1758028977
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e9c932a4dfso1276636f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 06:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028977; x=1758633777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oP4iLXlqo17dgLSrgkQgZcHvE5Do89KtwinnL3mfgo=;
        b=SHMB12tFnetApb3bF9DMWfHwCvMFT/oc9ucqXGQbfwp9M3v+TYfSO20On3EItnL/88
         JjidPNTt7ZSRBfqbL2bv8qUohLlJXS5BYfvORU3jDiDpzLfCfaEDa2Kv8asaCg/TUb1Q
         o5d4MLq3RxEV9vZIb04sZrFmfgvhy5czn4Uwg7l6LCLxG34Kq9DPcOdWRCEXTyXiTTSS
         Enhk8+NFM8NdmLr3ErsSSkDojEcln778sDy/UX8J2arcYFmLOJZoMTr237vUOMk1zWRA
         DFGS83uPo8ylaW7B6SgoO0xUPhCOwDGVZrEoiHKQjci/eG5BccrnLOXku9j56koxC5JC
         PLzw==
X-Forwarded-Encrypted: i=1; AJvYcCWC7ygapHpqX7rluDt/S1PBVyDab6WBA615/XBScTMlh0Ns1tM50QhAv/inQyyC0MjvT5mhGlHfaCqn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4g0KdXF/hYBds0NiKbj3rASjs7OlbTDgRro6R88yJZhtOp6J
	xrNNVovl5oz38dP/PTqpp7PfYLLQYCNRf6QJXgiisS5hqvz8E+wUsIUBEYSijBLeembLMEBp7Pu
	5VjG9w3K9jLK5wHTAhIE222Q9HB86SOg1tfgIduccxlxgWtuSiSskgrAUtAViphU=
X-Gm-Gg: ASbGnctQqxyJezsXBbaYUEPoqVBiyytpuS+kVHMtc+dr0A07ICEWxTzMFcKUOjPO06M
	DpzCDGyq7zvxLZAy15qj9wPY9rO1LHxMzM82ARDwP9lpvuRd+VTQz52VJcVp/KlFhEJGRg1OGQJ
	5P1PjK7+K/1m9mETLikkSW8UauugkYXUJRO2VZI7xN7whn02p1yfBSmFEvhhXMg00h9jW6uxw+C
	xP9PiEvyhSAZi0QHxqLmbQghlRlI1LdddhtJS6XWrbRQtZOSyPCIUzdGlgH+axVaxXPfT4zgAwn
	y4WQCWYCrqwnA+MoItUjcYpLUwDcN2a8+CqQTc+9bbI99A7On7f7lyr7lZtZDji+j2hiY1Al80v
	GNZ5CFcNMPdMA
X-Received: by 2002:a05:6000:1a87:b0:3ec:db87:e88f with SMTP id ffacd0b85a97d-3ecdb87ebbcmr933077f8f.58.1758028976901;
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ZY5gUmJ119iAt2SKTgVZxX4OPWSH9fLEx7WX7rL1qK5MveunydRadRnPWxfpxv4RDz+i+w==
X-Received: by 2002:a05:6000:1a87:b0:3ec:db87:e88f with SMTP id ffacd0b85a97d-3ecdb87ebbcmr933036f8f.58.1758028976410;
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e96dee54d8sm11914722f8f.12.2025.09.16.06.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:22:55 -0700 (PDT)
Message-ID: <0b5b0d1d-438a-4e41-99c8-a6f61d7581b4@redhat.com>
Date: Tue, 16 Sep 2025 15:22:54 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: mana: Add standard counter rx_missed_errors
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1757908698-16778-1-git-send-email-ernis@linux.microsoft.com>
 <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 5:58 AM, Erni Sri Satya Vennela wrote:
> Report standard counter stats->rx_missed_errors
> using hc_rx_discards_no_wqe from the hardware.
> 
> Add a dedicated workqueue to periodically run
> mana_query_gf_stats every 2 seconds to get the latest
> info in eth_stats and define a driver capability flag
> to notify hardware of the periodic queries.
> 
> To avoid repeated failures and log flooding, the workqueue
> is not rescheduled if mana_query_gf_stats fails.

Can the failure root cause be a "transient" one? If so, this looks like
a dangerous strategy; is such scenario, AFAICS, stats will be broken
until the device is removed and re-probed.

/P


