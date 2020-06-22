Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932CC203613
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgFVLqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgFVLqU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 07:46:20 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3288C061794
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 04:46:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w1so15102454qkw.5
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NBKzXepzy68inRcMiAHpgcaZ+EYis2uiV6fI4xhZtmM=;
        b=k8sCtVsIXQZTIM44uTx5XoGTEDbrW/uXOY8fvY9Nd/4DXh4saPSxYGA0cCfUbnlyLl
         tHW4PMUz+IUIg6iJElEk/IVvMc03r9mZCDo7PkP58fQDAGJJHKTvWbHlwGlvSkCSJBE9
         Ppej67LhjF9DHjvuE14BQiJBd6KnkgcnIxlNFcmKmCUHQqePe85Gy7qlE4M8VsBeHKUS
         yKX1U0jk0j5Ks8Y76HvcbvQtdxXTdUE006wQlY/5i2fjpanXsf+qNhaiup+oN8Qg8/ox
         /U6VE787P4r0dXZDbqERqe83AX626e55WkuKobSm/QiJ7uDeG7xH7wfc6SCv8Inqo2Uq
         QFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NBKzXepzy68inRcMiAHpgcaZ+EYis2uiV6fI4xhZtmM=;
        b=T3o9sLzH65OBf8+vtcHnBOHhWwegK2KMUDsrzJ0SPKPq5wZctzRJ1ycvwI/AXw3Y5z
         CDx2A/OSi075qlkjhfVsfbgRXXPQlQI5VynoReEBG0x5Mgl6QAnhaIqfebZJgln6fyVh
         N1BQcmU56SFrcfXZgZFkLxfxDos8fPs9Xji+k8SiOjdky9i4huI0/aOm58MPjh0Er5pN
         +Ih++BwtNaCDHJZ9v9Ie0KlEA57Sz+labWVBO0BHpaagqSOKgPcAe54zCZumywaRu0iT
         t8OxKTCStUJWGt8CPfQMy8iDa5PEeQSBP9lzoxh2AK+ZxfUbdkIJHJWcfj7ADYkoiUP/
         fxNw==
X-Gm-Message-State: AOAM531uOCDQ9NTXohjrpoMPr1X1W2Mr2wRpgwVV9I8c/divLj29ERD5
        ofihp2sc/G877PaPIptSZHW0ExEgkiZW4g==
X-Google-Smtp-Source: ABdhPJxthYjyMVCe6ZAxMUNKsmIMBTQD1YPg4YWyLhscgW6iJ+jy7QK2ERT6it0ZxPEWrnvgAqzIOg==
X-Received: by 2002:ae9:c00d:: with SMTP id u13mr15622504qkk.434.1592826379164;
        Mon, 22 Jun 2020 04:46:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r37sm14964604qtk.34.2020.06.22.04.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 04:46:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jnKu1-00Brwt-CA; Mon, 22 Jun 2020 08:46:17 -0300
Date:   Mon, 22 Jun 2020 08:46:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200622114617.GU6578@ziepe.ca>
References: <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
 <20200619195538.GT6578@ziepe.ca>
 <20200619203147.GC13117@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619203147.GC13117@redhat.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 04:31:47PM -0400, Jerome Glisse wrote:
> Not doable as page refcount can change for things unrelated to GUP, with
> John changes we can identify GUP and we could potentialy copy GUPed page
> instead of COW but this can potentialy slow down fork() and i am not sure
> how acceptable this would be. Also this does not solve GUP against page
> that are already in fork tree ie page P0 is in process A which forks,
> we now have page P0 in process A and B. Now we have process A which forks
> again and we have page P0 in A, B, and C. Here B and C are two branches
> with root in A. B and/or C can keep forking and grow the fork tree.

For a long time now RDMA has broken COW pages when creating user DMA
regions.

The problem has been that fork re-COW's regions that had their COW
broken.

So, if you break the COW upon mapping and prevent fork (and others)
from copying DMA pinned then you'd cover the cases.

> Semantic was change with 17839856fd588f4ab6b789f482ed3ffd7c403e1f to some
> what "fix" that but GUP fast is still succeptible to this.

Ah, so everyone breaks the COW now, not just RDMA..

What do you mean 'GUP fast is still succeptible to this' ?

Jason
