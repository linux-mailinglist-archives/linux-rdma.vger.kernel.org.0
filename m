Return-Path: <linux-rdma+bounces-15494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CAD18065
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 11:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A25D730428D1
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2C38B99C;
	Tue, 13 Jan 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NClj29oc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l7rblCDK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690538B7B3
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300078; cv=none; b=r/YkK62FKtdxLLKp3eHjAN7B1FGPmfa3C5yQChkHq0Pn6UCmYVUu/IeoacNlok+f6AAINlg2RgIOAahrCOzfePWB5d126mWc21wobqv07iMOOCmNALiJNDGCpuP3dLOs+1qIVRDrjdGfRJpz2ANSj4vIkinfw3vqhKKHSwZNShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300078; c=relaxed/simple;
	bh=Xs40V71NSFgBl8ux07wXA+nnPiuQ97Bp4CQVChxYDDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8NraDfbGkaP+d5iYu6yvDkn4GcDa2BKIoruRnGOk8NpdxS2KKP9TpQsRyvlSk3ha86mss/03BESMiEzJe+MOlJ88yrRxeal2S/nzV04AmLSxbtiEH2EP8s3t1FjIT0pl1PivwCDPyc2/BT7tUlQ4MDDgvBFlBjRzSsRBdnVzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NClj29oc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l7rblCDK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZv6AyyuLVVLAZ1eQ6zjrtIwS0o/q5F3gCFQ/xz3D2k=;
	b=NClj29ocrXBwpERDSs1D7BvqCTEwbxSgumH3xypeSfL4Ed1Ul5PKrpFSr0Zqi1kDKw0IOq
	geC9aM/QNMyUGf+dBIEBdbl3VjYb128jEagbVYrjEoWCoIYCG3nxNymrrRWwA25LW/cSZX
	CBGoFJFSfV109z2rwkiUrHPUq/Zt2ek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-els0FmTpOoGvCraLkk7gqA-1; Tue, 13 Jan 2026 05:27:53 -0500
X-MC-Unique: els0FmTpOoGvCraLkk7gqA-1
X-Mimecast-MFC-AGG-ID: els0FmTpOoGvCraLkk7gqA_1768300072
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-431054c09e3so4333352f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 02:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300072; x=1768904872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZv6AyyuLVVLAZ1eQ6zjrtIwS0o/q5F3gCFQ/xz3D2k=;
        b=l7rblCDKgRS2I8oTRrwQ581FzINuB670SWOuseGwHOQbWyBC9dTt+/5RgCIcU/9EE3
         XD+IsZvDDq8b60X5k3xH3B7rawc5Q/fSX8JH2v/YDk1hwJUCm4BcV/Alz9PK66UotQaj
         gZcHrNG8OALEVy2ggRJTjuUOx5FIlJ49Z5OXAUSuRx8rLxpMyX1pME0x0488fM48QgJT
         CW/durgdG8PRaW+3XLBL4lQxoIRpUG8vU6Q8ZbgAITczA+8hnfDGF1d22IrrZ3E5G52Q
         KotZHPmbkOc6rxF6ydk15WebD6IDQd52YzwP3VMoCFuyMMHlmen3U5EcrQTrPMPhGLUB
         hnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300072; x=1768904872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZv6AyyuLVVLAZ1eQ6zjrtIwS0o/q5F3gCFQ/xz3D2k=;
        b=k+6MoRsvPisyyfF93PU4h4FYnV1mSgxWAO4bCS7Dk+ZPXBX0haPva9g7HaktpDJjnw
         IFPyM/4kKtKK7PK2p+Ek0G3kVgKztAO6bj4Cj5RkDg3Ql529dQk65Lru/FiVT6BjiIhp
         1H8nj/0IZ0jUc3IE+1s2crwKiQBhTQSH5xeF796Jo2k5OxKPm75lvnQpnY6M9npzyfAt
         zPGffxFUagon5hJWkYUoEnM904meiaX93E1PPA4TAsD+tbZhk7HlUPCvLb3C2MncNTsl
         HSBNr+9D/u+rFEa6p3o/ocP2BIFw6vr3c2IDpFxxWQyPTqhyHb/xzyvFTneLf1MasX2P
         Taog==
X-Forwarded-Encrypted: i=1; AJvYcCWLMCYZBWGH9fonOBWxBsece1ASi4ak05938s89UcXrozuw778o7VUUVXqTKCkdRiLKFO7AWG0vP6bD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3CCSFwp+FczmfoQIDdGBtIy211GVFaqT+ZpS/w40Bt4IUg/d
	dWpgzc+/+oa/LB6ywySDc0SFOJYxkoxzy3cSTcNXhlx/Xh2tlWLh2JBoRLmWDVcrqqvPgtq6lah
	55Cwliz6WsWl37T7Mih67PocQNGqaKB1+rWkBb5DKBEa8SI+Hb1/sUUbOWdHgXxk=
X-Gm-Gg: AY/fxX6FhPy/OUXapgV5CoBpCXJAQzk7qSk9kb7+aup0L0ZWL51ehGBBRlSC0cV4S/c
	iWK9dK/Pp345/gjDvEaL+WPHrtlLLEX72IIAbQSY1TgatLtRXDTXsMTgBCkwndzyHe+Wm2WKNtW
	xuD/ZkcDL8az/jzhm6WIgKvg5vTk3oz6Odp59G9mt11WqJHGtyS/RB0ZR8LTn6rvjOfSSr4XKBe
	jLEi76fE09CfCRenE1leOC8/Z/dC6y2CHMgPVf8CkAVwHunAFcSRNJd8yrnvZON28BxrGEcxpmU
	pK0V7EsQV81y3IXGROR06n2esRrpfzROCclHLCnmeLCqfyoNrPAltHIGVxZ+gQyT5nl4OkyPGDm
	Mo+ojyKsrZmac
X-Received: by 2002:a05:600c:c10f:b0:47e:d6ee:7dd1 with SMTP id 5b1f17b1804b1-47ed6ee7dfbmr30480645e9.2.1768300071571;
        Tue, 13 Jan 2026 02:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBi8qAsCyoUj8yK3DWWfIteg/UVGEMMZ3DTwKr3HpHFkur4u7m4Xtrpa9L15tB9tU9SsSBiA==
X-Received: by 2002:a05:600c:c10f:b0:47e:d6ee:7dd1 with SMTP id 5b1f17b1804b1-47ed6ee7dfbmr30480125e9.2.1768300071047;
        Tue, 13 Jan 2026 02:27:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm408197555e9.6.2026.01.13.02.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:27:50 -0800 (PST)
Message-ID: <4db44c27-4654-46f9-be41-93bcf06302b2@redhat.com>
Date: Tue, 13 Jan 2026 11:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 6/9] eth: bnxt: adjust the fill level of agg
 queues with larger buffers
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <8b6486d8a498875c4157f28171b5b0d26593c3d8.1767819709.git.asml.silence@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8b6486d8a498875c4157f28171b5b0d26593c3d8.1767819709.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/26 12:28 PM, Pavel Begunkov wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> The driver tries to provision more agg buffers than header buffers
> since multiple agg segments can reuse the same header. The calculation
> / heuristic tries to provide enough pages for 65k of data for each header
> (or 4 frags per header if the result is too big). This calculation is
> currently global to the adapter. If we increase the buffer sizes 8x
> we don't want 8x the amount of memory sitting on the rings.
> Luckily we don't have to fill the rings completely, adjust
> the fill level dynamically in case particular queue has buffers
> larger than the global size.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: rebase on top of agg_size_fac, assert agg_size_fac]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8f42885a7c86..137e348d2b9c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3816,16 +3816,34 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>  	}
>  }
>  
> +static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
> +				       struct bnxt_rx_ring_info *rxr)
> +{
> +	/* User may have chosen larger than default rx_page_size,
> +	 * we keep the ring sizes uniform and also want uniform amount
> +	 * of bytes consumed per ring, so cap how much of the rings we fill.
> +	 */
> +	int fill_level = bp->rx_agg_ring_size;
> +
> +	if (rxr->rx_page_size > BNXT_RX_PAGE_SIZE)
> +		fill_level /= rxr->rx_page_size / BNXT_RX_PAGE_SIZE;

According to the check in bnxt_alloc_rx_page_pool() it's theoretically
possible for `rxr->rx_page_size / BNXT_RX_PAGE_SIZE` being zero. If so
the above would crash.

Side note: this looks like something AI review could/should catch. The
fact it didn't makes me think I'm missing something...

/P


