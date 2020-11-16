Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606592B4F22
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 19:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgKPSWL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 13:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgKPSWK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 13:22:10 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD7EC0613CF
        for <linux-rdma@vger.kernel.org>; Mon, 16 Nov 2020 10:22:10 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 3so13617125qtx.3
        for <linux-rdma@vger.kernel.org>; Mon, 16 Nov 2020 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PeAp6rv3b0KaovCr5DVFoZnWSd8lGfDtnKsxYjCXXc4=;
        b=aDa/ljmo1O9xRlNw10G/1HntJ+5KS05syOPUZCraTcuvn5168NCLwgx7+FIUoFHN9S
         DPpoD8VG3yB4tKslJ5adAdKyB73kv1Q7CpzHLdkhQk0pBypfko/Ali+paMBfS9pKcHqh
         bgAsHbJ8kU7BFmR3yU+IARJvF4JB5j/Svut3KL0OcgQ+FjNFvxHTYqMNRQzUppW4u3+1
         muN2dir1AgVXEu6P7/OAeiinNGugvkN1uYu5TJ9ZtNSHf8apdOneq/51TWTTnzx36HCZ
         TI3uMVNqt+LvoEOWrRBx/X8rLwKVMJ8NgGhtjCZzd2Yjx15+O8aAslmdG0DvaR8SzfHb
         /R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PeAp6rv3b0KaovCr5DVFoZnWSd8lGfDtnKsxYjCXXc4=;
        b=pSjkK6jAJSguYngyQYfxZg++xSZP1LRQt2SIfNknkK/QR91QnWxACxKuxLPeKpmliN
         LDYJuxoU3OmLx8ecGjU640eJKHkuK5ieOCTxaXtALlvdm2uQCyGcqhpZRUkaOOqDwH71
         rikD+6jEtlULZQQnGgBrdyf8S4JD9uj5sLTxuppj+tW+sRlcQCGT2WkOLq5LxSdbuMK/
         nG2A0wVBqPiT+q+/Baq0fwA1DIE35eU90k+HMZM0EGgNlyG3D0lGt6/9nGG7opgByfuO
         XDND0d43FWd+4yYM2lv3wbLQI6hoo74p5oSn9YDY+EbxhoaJnESkHJCq/ifjCfBnFObg
         cuzA==
X-Gm-Message-State: AOAM532xLAArp7mZ2N8nMh1mDJp9rdYcxHR9luNv7U/KzOxbxAZcPSwS
        xw40z4jEowHQKfUeP4yXvgzSwiVAvE1llree
X-Google-Smtp-Source: ABdhPJwdP/HmrCk5+opVv3vkd4MHZTxisNc2rfN3Er6aDod+83Kg/fbVCYpPA2xCRciPwpx26oL/PQ==
X-Received: by 2002:ac8:6953:: with SMTP id n19mr16038786qtr.184.1605550929613;
        Mon, 16 Nov 2020 10:22:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o16sm13348862qkg.27.2020.11.16.10.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 10:22:08 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kej8h-006OiW-Vi; Mon, 16 Nov 2020 14:22:07 -0400
Date:   Mon, 16 Nov 2020 14:22:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/2] RDMA/core: Check .create_ah is not NULL
 only in case it's needed
Message-ID: <20201116182207.GF244516@ziepe.ca>
References: <20201115103404.48829-1-galpress@amazon.com>
 <20201115103404.48829-2-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115103404.48829-2-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 12:34:02PM +0200, Gal Pressman wrote:
> Drivers now expose two callbacks for address handle creation, one for
> uverbs and one for kverbs. The function pointer NULL check in
> _rdma_create_ah() should only happen if !udata.
> 
> A NULL check for .create_user_ah is not needed as it is validated by the
> uverbs uapi definitions.
> 
> Fixes: 676a80adba01 ("RDMA: Remove AH from uverbs_cmd_mask")

Why is this a fixes? It makes sense in the context of the next patch,
but it doesn't look like any driver sets ops.create_ah == NULL ?

Jason
