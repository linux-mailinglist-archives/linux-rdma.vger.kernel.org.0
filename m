Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB823FD4C2
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 09:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbhIAHwJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 03:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242622AbhIAHwJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Sep 2021 03:52:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F4D2601FD;
        Wed,  1 Sep 2021 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630482673;
        bh=D3Qw4qsicvLlEyVqEEjrbY0bbgUgu1lN4Aq+X9kwP84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nouByuKC6jzZ8jqIIOLpyN4qDzsH+m/jVAebV+it/0RMXY7MAp9u4evlTSy+baK7Y
         M7rwri+3Wzx+luqqr8e1t+ye4UwhBGCmZe9AZUVLmdyx+xIOHvAu7QsnLgR9sbZegP
         zmj32fxaGUPP5BHCNzhgNAu437e4zFLFIlSCsyDK+WRG9+KjNY1fUzxrFDHuXzJr/x
         oAFhJWqlha3Pgu6EjTZKRGN5QaAJcBg/KejRKevg4xZAnWGKxZVbTvwXSlid5wfnTo
         r72/FChcLVQ1GwL4iWrLqecwIYDXS6NQ+BCow5u3PMBFvN3vpKYIuJ5tB8ZotnwN1x
         SVh38CVr/InoA==
Date:   Wed, 1 Sep 2021 10:51:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "kangning18z@ict.ac.cn" <kangning18z@ict.ac.cn>
Cc:     "haakon.bugge" <haakon.bugge@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Re: [PATCH v3] Fix one error in mthca_alloc
Message-ID: <YS8w7c9yQKu7s8a9@unreal>
References: <20210827005228.15671-1-kangning18z@ict.ac.cn>
 <YS371Qgef1FTTrHZ@unreal>
 <202109011027459851120@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109011027459851120@ict.ac.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 01, 2021 at 10:27:46AM +0800, kangning18z@ict.ac.cn wrote:
> 

<...>

> Thank you for your review.

Do you have mthca card in hand to test your changes?

This driver didn't get any changes for a long time and we
don't even know if it works or not.

I would prefer to minimize changes to that driver.

Thanks
