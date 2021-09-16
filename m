Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C344540DD9F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhIPPLX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIPPLV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 11:11:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FCC061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:10:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j6so6204548pfa.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9GaDt44DvVa5yv0BTHVUlCYXm21MbfWGjK+Ln9BEtmU=;
        b=e/XpJBPL6zMGo+sX0ajpjtfNKUNUdeqq27qtY7mszardM/sYxTSLK7D6Wijh5w2Fov
         i8qivj9Ly0LvNVhWqHugkzq7YW/+1LwI2mUbQrFrhMRSwTl691l4AVEtFG8Aang6PiAD
         NFB0QdLN+SdRJ1Twvy+/2GnCA3tMZMjDRslpIEsXtvVQhtbyCDMeAvEg9LYa5Ctatn9V
         928SjyFeWuXBVqYsMT7DxUlvU+TeG/F27yJI8R8cQQTgRjphUNq2m6EeBWwPsDkkYeXX
         AfiG3ILBrvehGv7IVtnc7nHYpbt4DmFYGEZH/GAtJTV8ybS4SseIqvITOxVnX/6/XiCX
         hQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9GaDt44DvVa5yv0BTHVUlCYXm21MbfWGjK+Ln9BEtmU=;
        b=2ncgStZUGGk1khywGSKjzALAavFnzSoXiJEPJdsJPZEHyoo8IDLMLdqfiwak7SkpaY
         OkEXn+Ikvw+kP1phM0aa2qDVeJnfaQpi1iJ0nO3Tr51ci5FqckkU6DhHLhvG4mrI1N9G
         Mwi3Gyg59hYxDXEnMUUBDopf0p3LatR9Ss8gzQnNPB24V0QjnXOOR0rc0NeURdVW28tb
         5WEDqXbh9Og0pgBrKkpzt68UjyzcAvV6iXCwDTNuvGXmyDof2Cr28enC3IOSLpvb15zp
         qRts91cvqxJ4O3OFR55OAu+hnGUeBa1PbSGFiMoFtIJ0E87rj6VML6jAy99/jMcHYqM+
         3PzQ==
X-Gm-Message-State: AOAM533GQbg/gTs9VvJC8IldPQek9PISgruA2wF+bT2zAa6j4/TDv+n2
        WomwQ3/ayX7Of5EoDETfIXkwww==
X-Google-Smtp-Source: ABdhPJwpSjPTO0kWZyQzEGoxpuI4RuD6ZmFpO5j5AC5dDAjPHMSKtpS8+IuIkgo3l9lSqf1hDe/DqA==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr5354833pgv.370.1631805000289;
        Thu, 16 Sep 2021 08:10:00 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 132sm3474786pfy.190.2021.09.16.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:09:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQt1S-001mbf-88; Thu, 16 Sep 2021 12:09:58 -0300
Date:   Thu, 16 Sep 2021 12:09:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Disable atomic support on VFs
Message-ID: <20210916150958.GO3544071@ziepe.ca>
References: <1630037738-20276-1-git-send-email-selvin.xavier@broadcom.com>
 <20210827123146.GH1200268@ziepe.ca>
 <CA+sbYW1GoGu_U1c_zKEbXyqgK-t+Mwe1aaFY1vsH1T0QCj6KAA@mail.gmail.com>
 <20210901115016.GQ1200268@ziepe.ca>
 <CA+sbYW1uhvNFjwK27UarY-KPA=tLSMVeGXzcD4i8aWnqeGsUiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW1uhvNFjwK27UarY-KPA=tLSMVeGXzcD4i8aWnqeGsUiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 08:35:37PM +0530, Selvin Xavier wrote:

> Hi Jason,
> A patch that avoids the crash is merged to the linux-pci tree.
> https://lore.kernel.org/linux-pci/20210914201606.GA1452219@bjorn-Precision-5520/T/
> With the pci patch, the host will not crash. But driver will get
> following error message when called for VF
> ""platform doesn't support global atomics."
> 
> we want to prevent calling pci_enable_atomic_ops_to_root for VF
> anyway. Can you please pull this patch in bnxt_re?

It doesn't work like this you have to wait until v5.16 for all the
trees to be harmonized. You should take care of it in your internal
testing tree in the interm.

Jason
