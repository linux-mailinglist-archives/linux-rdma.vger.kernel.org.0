Return-Path: <linux-rdma+bounces-6180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D437A9E0A93
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 19:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4EFB87541
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1C920DD73;
	Mon,  2 Dec 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oMeZ9SGO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5B20DD62
	for <linux-rdma@vger.kernel.org>; Mon,  2 Dec 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150777; cv=none; b=OoV0c6DXGU2jCbzb+anIPeL7v1IlYkBbCQGSW4Dfg624HZoDSp0MYiQFkps6x9TRiLBlx29FtXJHX2W2vmeTUqwwyadvALSKtJ1/tPtW9RAhRRdZnzO0Om3tnub7+yjw0EkVQ36mTFFfrE73/899Ts4+1DyJr3Ufedpe+kMfjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150777; c=relaxed/simple;
	bh=iKl4ZZTxTItyR+ijhPG6Nd6Nb2U05AAUvoQZti77rnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic8SDw5CuXz1NVXUCnHyzylfCzBcaWrj3IE7mQ9gs66UkHC4tZcgvnz0PtH/tAFqxA5odN5x/pKB/jtBhdWIKMypocJJX97TCO57Jyel5tjwPHkiB2CMG81QDlgPShf1HSJ0ttWPHBwBVGgZ0nTTpDhL7YUbl1YAC2tsIkGYLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oMeZ9SGO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46677ef6910so27866701cf.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2024 06:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733150774; x=1733755574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKl4ZZTxTItyR+ijhPG6Nd6Nb2U05AAUvoQZti77rnU=;
        b=oMeZ9SGOpho7Yc/q/bOnnTpdlZtktycloyGopd3BLn3kbXIFx/WBQYSJCtQFkxiL46
         BxMhTxTYpPjJ+Rt/9zosLt3TGzipr0BOvOgj/w/M0X8phjkjl3WCfG5lMVw+oUn4PWw7
         0DHmSi/EXEpPgii06LjmpZHdnezn/yrs2Cll6eIqyAUhPI0AEOyme7UybD5qKoIdO7mo
         8z9TcaqToHv43HihbNlyAF7o/EnHeLu2w02oKjsi+TWh+EusoanJTpIDwXY5uL0NfLMr
         1C9qMMP1uGBfYwRcYOAW0E+vMrU7Rokf8gGT1FcovzGoZqjrWi6ep1HROKvau+dXIqIR
         frjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150774; x=1733755574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKl4ZZTxTItyR+ijhPG6Nd6Nb2U05AAUvoQZti77rnU=;
        b=NcW6K+IPG0zK2M5gTpR3SotPLgJ/oZvo1vpmLVzX1qHatXwVEFadlGODVu5r+Yalu+
         t94ai4EjuTw10RczxkWeFrazWIX4yAexV7Q9xcB1xzSr/M91WOnDyWHiga5lFvPNGwzW
         XviCPqm08yfq7ah//djfemUmAFeZvEA7u4vNPjXphE/so9II3Jx8sIY4tD4TK/EZJ34E
         Heh+fLzfmTFODsuOjqzAIeimQPgh7WuvOMs0yWnXfe/P2MTaeRF6YzrvN/0hm8NSJPm0
         mbbm93KI7WLFJm+NIp1rBnMIf2R4TKFerMPedPFYGZQmsLFXfYn+8mHGOS6KdG17RUiy
         fBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE+FGnlUy7ZwD3pN8SXJgunjmOHfi395v37PqRIDV4LoMUIJJfdkumG6Tv5A+TnIUIJbl1BOyanZwO@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGv9rLJHVwjliEa0lJxP/thpkxCltIe/X1THX11XSE+BO7Btz
	r8mg/msXYUE3vShcgFFbxOlpiQ+nulQ+0iC0sNC+za/rvtS4RdlSTmKtE9I/gFg=
X-Gm-Gg: ASbGncthxIUnwY9hP6qRWBWKS0yrXkGrTD+Iv/BuzvkW3XleUK9rF8LSwASL85pqjsg
	l1qfg4VmHJJXWChQZIHWj+533HBygRLcnWmioasyxmXw17pZK+JdyKy+7FJ+7mqFIzYdCsDAOyY
	oAkYx5t3hKOCw5m2p1XkU+qRCWUGhEGOExOZDzfu0YJUSBAX/UZbJslGzu4aZA5LF8oVMUm+PFF
	xcPIQydB7bqRIQLqTsZ6deGsyFZuqE5SesKIS1hOLpS7KmmBTqUVsqc1y+4JihEvTHEOOc8zHAw
	+srE0qWORI8GhiFbc3G6W7w=
X-Google-Smtp-Source: AGHT+IEuXOONcnxVlr1zPCd80wZ0Z7aTwqF/Kslui/E/Z0xyTI3miI7kqgDU/U2h29/UE6B6MUQmBQ==
X-Received: by 2002:ac8:5a49:0:b0:466:a9c2:640 with SMTP id d75a77b69052e-466b3656462mr355695531cf.44.1733150774181;
        Mon, 02 Dec 2024 06:46:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4067277sm49044111cf.29.2024.12.02.06.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:46:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tI7gi-00000007E6x-16B1;
	Mon, 02 Dec 2024 10:46:12 -0400
Date: Mon, 2 Dec 2024 10:46:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot <syzbot+list61c5ef3632c5b9ec2d7d@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly rdma report (Nov 2024)
Message-ID: <20241202144612.GE773835@ziepe.ca>
References: <67498180.050a0220.253251.00a9.GAE@google.com>
 <4b5cbf38-ce6b-48ee-aa50-e23a64ba7279@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5cbf38-ce6b-48ee-aa50-e23a64ba7279@linux.dev>

On Fri, Nov 29, 2024 at 12:30:37PM +0100, Zhu Yanjun wrote:

> When pd pool is not empty, it seems that at least one pd is not removed when
> rdma link is removed. The caller should check the application to remove this
> pd before a rdma link is removed.

The bug is that this somehow happened, I think. There should be
refcounts preventing removal of an ib device while a client is
attached

Or, perhaps more likely, it is a pd leak on an error path.

Jason

