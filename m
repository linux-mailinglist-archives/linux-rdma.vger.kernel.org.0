Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91319415867
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbhIWGr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 02:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237097AbhIWGr0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 02:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 286036109E;
        Thu, 23 Sep 2021 06:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632379555;
        bh=DcdqZe/8oJKOdfie1myAF2t6sQK3xoiQdpivVylQs10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vba/voXJQYEjDRI2BX4tTGX4a8ruUtFFi6dBHOxW8t4/xFSiZE6hurA28+ib2f2RN
         5HnvKot/+/dhKZ8topDFTrxGLYKlDl1d1Ri9OZqJ933FbeQGTAZusPFWQI8bDUoGME
         V41JzpZ7TZAw5XNc9Djjg8Qto6qgnpUBpd34JdEGOTOVoqTJNnAOYazfA7NSp7kei9
         pYEHbYmnulveAChVrduVJJt0yJHFZuNG919VMlmENR83NZcb6/fIYT7JyMB02Bq6Ad
         +m0uiPbfgGqfo69x1F4uRLqRlhGRCRuVNSzwmFI823cbQ0NOKYGjFkut02gE3eDKmA
         36IeHpIDeEYow==
Date:   Thu, 23 Sep 2021 09:45:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Message-ID: <YUwin2cn8X5GGjyY@unreal>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 11:05:42AM -0700, Bart Van Assche wrote:
> On 9/22/21 10:51 AM, Marciniszyn, Mike wrote:
> > > Subject: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
> > > 
> > > Pointers should be printed with %p or %px rather than cast to (unsigned long
> > > long) and printed with %llx.
> > > Change %llx to %p to print the pointer.
> > > 
> > > Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> > 
> > The unsigned long long was originally used to insure the entire accurate pointer as emitted.
> > 
> > This is to ensure the pointers in prints and event traces match values in stacks and register dumps.
> > 
> > I think the %p will obfuscate the pointer so %px is correct for our use case.
> 
> How about applying Guo's patch and adding a configuration option to the
> kernel for disabling pointer hashing for %p and related format specifiers?

Isn't kptr_restrict sysctl is for that?

> Pointer hashing is useful on production systems but not on development
> systems.
> 
> Thanks,
> 
> Bart.
> 
