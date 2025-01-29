Return-Path: <linux-rdma+bounces-7316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE85A223E0
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593411883F47
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07F1E25F2;
	Wed, 29 Jan 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gWMKOkZe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204BB1E25F1
	for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175413; cv=none; b=sXJZ/KFva6hA1VbDwZC0qS2gNL3lFio9cm8clgOuSEfQFuCBSxXmlHfPopChW+mA7Ekv6EKfHugWEEPhjZLCBs4B8woCiuXD4wpGYBlZNcHH/SmjtLkurO3H2lS7I2n8G3tENZthwvH1o6Ao3C2TFrxZJgtsDiLD8FcN6gGxDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175413; c=relaxed/simple;
	bh=V3h04rIV92zeS1OapG9TdeCcYQBzM7Gky3PA5S8ttac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW0tDdiqavdk7jjfbt+hj8kyv37YtD1UwO2TRLEbqnr7RbEIRqmXoFZ9cAqiXHk1vnIAN0gQUxZpSzQ2IwTNL2R3AifV5sAauzD28fgDejiiOCwG28pLxP+eQe72ESPj3col2LB1XPJydwbIm3Dt10dk8DYCEZfbBnGj3TZOTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gWMKOkZe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467b955e288so76126321cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738175411; x=1738780211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XD0YMmssfsqTqz7P5jLcOM43e1brk96cTTh0E8gXUWI=;
        b=gWMKOkZeoonN9reatGYy3NItD1BQNy3gZcIx0EUMgPU5ovj2ZHhjagXA0Ldxu6HhUR
         g/cLRHRWp2KPQU8xrGAAPU62/qs1c1aowWB8ah52/4C8q/6gPusbsJF0ttjP/cSb+8tQ
         LAOkWd7AMxZJC6vhc1wpJxzuy8L2e+02X7RwoO8YEqgEOmEtyqHiwjLIQKYLHpZdE9Xh
         zaJpnVw1N+zbydM5nHBYa7GSX0yJyOfpz/4jLS/02j4IxiHclkvob0xsccYQ3Cl0xPoq
         tZ4+SL2UQGnVog4YwGTk4vgsfg2kS2qemG6ZgFXjttCOMa/fPpcd4ousX91clx3UZuzN
         KCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738175411; x=1738780211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XD0YMmssfsqTqz7P5jLcOM43e1brk96cTTh0E8gXUWI=;
        b=DweNx9nr+uB8FlEFtF2ds704Kv6NghN8lzbCxKpymPGu11W7zURVjyKcXMlZCdjBID
         T9bEODq6alb+YfF77PaxVzcF/+VbdEF5SVTCB8ITv55RfxB/w8ptlIW3pTR5o1nKWAuT
         ej0JHT/5RgByP/XA5VFq6qY6y5AygvzjOF7FSkCysBvzOKSp2OyT0furzEejLl+QY43Q
         hS3Z9RGcY7s49ObJDbwu9CcyWgb+9juAmqLCAcrFGWs8tv9MtG4RWkF/DSXJpDWSvEYz
         tEQahu3Sq6U98inWIfG8Qc67KxpLkUShTkHx++Q3l5lxPGWJPOT/UnmbEXvyamFsMNbO
         ln0g==
X-Forwarded-Encrypted: i=1; AJvYcCUwzYyH0HLFRdWb6wqvNAT1xNcUbFBGo8J88MSCHl3EhyBosPu6Y06wD5yuo+vN7k0k03LASdqWH0gB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy155b5dZJ9J7Es3dADUCY5rHgSGwzNPWULJiC3v9nHRk4g6/Iu
	EiyxW4uQeQ1MF9/3iqGY+VKrrEvTZ6mg8ivqDaBEtdSw3kuoEk3zOh83YYT/5DQ=
X-Gm-Gg: ASbGncteGP5AZ1GSKFBHfwgoj6pSEq5jfhwo4G9Aar6zE5TNFCUrldsvIumDpBVtJcI
	y9nsrkM078QHBUm+hfe3gxHff/McCb7M+AK5UjIKt+kbHKPoYn0UahrhPDcEx+S3+jPJffU4M8m
	wahZtWdU7uSLMOeFRAB5UZ7XORKXFbn5TVj7FJIyJSdfKwMeL2cAH82XpuIPfOZOZn9CtoYDTFf
	UFOKzi1PQE8Z8870HDa1oUwCq5CxKI51xv+Po44yA+zJWuR9OCzgNqh4gtkdWrl+axnsQkgXY2d
	D8V6cCaw56Es14CTPxcAYR72DUcspMDM2Lc2T3BVlec18fTOIJu3LUZqqyyde8vo
X-Google-Smtp-Source: AGHT+IFU2CSEw7nEQnS3hKi4MzP25PEd5L1/HqejOvMmapaGN2P5mirb8xGOSLzYxz2tblSZd8yYPg==
X-Received: by 2002:a05:622a:47:b0:46e:23dc:97dd with SMTP id d75a77b69052e-46fd0bda6efmr75744211cf.52.1738175410947;
        Wed, 29 Jan 2025 10:30:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66b89811sm64595011cf.77.2025.01.29.10.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:30:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tdCpF-00000009Qzj-3huR;
	Wed, 29 Jan 2025 14:30:09 -0400
Date: Wed, 29 Jan 2025 14:30:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
Message-ID: <20250129183009.GC2120662@ziepe.ca>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>

On Wed, Jan 29, 2025 at 10:44:39AM +0100, Zhu Yanjun wrote:
> 在 2025/1/27 23:38, Eric Biggers 写道:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > The usual big endian convention of InfiniBand does not apply to the
> > ICRC field, whose transmission is specified in terms of the CRC32
> > polynomial coefficients.  

This patch is on to something but this is not a good explanation.

The CRC32 in IB is stored as big endian and computed in big endian,
the spec says so explicitly:

2) The CRC calculation is done in big endian byte order with the least
   31 significant bit of the most significant byte being the first
   bits in the 32 CRC calculation.

In this context saying it is not "big endian" doesn't seem to be quite
right..

The spec gives a sample data packet (in offset/value pairs):

0  0xF0 15 0xB3 30 0x7A 45 0x8B
1  0x12 16 0x00 31 0x05 46 0xC0
2  0x37 17 0x0D 32 0x00 47 0x69
3  0x5C 18 0xEC 33 0x00 48 0x0E
4  0x00 19 0x2A 34 0x00 49 0xD4
5  0x0E 20 0x01 35 0x0E 50 0x00
6  0x17 21 0x71 36 0xBB 51 0x00
7  0xD2 22 0x0A 37 0x88
8  0x0A 23 0x1C 38 0x4D
9  0x20 24 0x01 39 0x85
10 0x24 25 0x5D 40 0xFD
11 0x87 26 0x40 41 0x5C
12 0xFF 27 0x02 42 0xFB
13 0x87 28 0x38 43 0xA4
14 0xB1 29 0xF2 44 0x72

If you feed that to the CRC32 you should get 0x9625B75A in a CPU
register u32.

cpu_to_be32() will put it in the right order for on the wire.

Since rxe doesn't have any cpu_to_be32() on this path, I'm guessing
the Linux CRC32 implementations gives a u32 with the
value = 0x5AB72596 ie swapped.

Probably the issue here is that the Linux CRC32 and the IBTA CRC32 are
using a different mapping of LFSR bits. I love CRCs. So many different
ways to implement the same thing.

Thus, I guess, the code should really read:
 linux_crc32 = swab32(be32_to_cpu(val));

Which is a NOP on x86 and requires a swap on BE.

Zhu, can you check it for Eric? (this is page 229 in the spec).

I assume the Linux CRC32 always gives the same CPU value regardless of
LE or BE?

Jason

