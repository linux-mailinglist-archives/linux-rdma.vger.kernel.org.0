Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3B397233
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhFALSG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 07:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhFALSF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Jun 2021 07:18:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14BE6613B4;
        Tue,  1 Jun 2021 11:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622546184;
        bh=vgObDi0w/WOhgzUmHwSxN+bIji2gl6xSVnK4VlfhTbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2+EUcvg24fqMJPK9pOKCKEOcBoUE32JRXobpeH6r6Rx3bxXIYhqx8TxCB+jHm2nr
         OSkIaAyxYSWxjnedzk4LbmaJXt9x8Caj0u2ci1DivwF1aqfBGD3MO9V2yichCV6Smt
         aPVmeE7CBeLR4bZgLhcluJ0Ut5dEFbQb6VetZVvS485fG+hkS33yVggS5Pn62ZdUQJ
         4m14az0FhglZFDevmKteWrr2H1kue6bjFPEj7Mwwp3Kl2duF1m/e3HHsGgTrIyl99L
         ZQ/aj/YBlLbvE9xB892b29xz+a5OdBUnFi5YftTzQX79M34OAdO32TvRWVZffW0Tad
         1DtoE/9cj3oqQ==
Date:   Tue, 1 Jun 2021 14:16:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     linux-rdma@vger.kernel.org, lizhijian@fujitsu.com
Subject: Re: rdma_get_cm_event error behaviour defined?
Message-ID: <YLYXBD9jupPOslnR@unreal>
References: <YKJAKy1oNcTd7sRn@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKJAKy1oNcTd7sRn@work-vm>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 11:06:35AM +0100, Dr. David Alan Gilbert wrote:
> Hi,
>   Is 'rdma_get_cm_event's behaviour in initialising **event
> defined in the error case?
>   We don't see anything in the manual page, my reading of the
> code is it's not set/changed in the case of failure - but is
> that defined?
>   It would be good if the manpage could explicitly state it.

AFAIK, the general practice do not rely on any output argument if
function returns an error and I'm not sure that the man update is
needed.

Thanks

> 
> Dave
> -- 
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
