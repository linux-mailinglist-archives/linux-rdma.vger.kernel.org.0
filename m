Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A8677D1F2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbjHOSg7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbjHOSgl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 14:36:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB219A0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 11:36:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-688787570ccso294112b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124598; x=1692729398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0LBEq/ZB9sIsZY2ixET4uGg+0+u11MKT3Wxwnk/wWo=;
        b=BPRjfgbjq3fjRgi7pj7IXcD8k6Y2m9zULdXwBcTRGVTlkp+4mTArkqGgUgU3OctXax
         mPeYtxzCO3cC+91N6Xc4128sAQnx8U6AymYxDZ2OnIQGFNpg/+iung8OG1u9npixX4fn
         FXC2xMhaHhitQ9nj4GfOg4TnuSGZMeFGmDG4yA8rXiLrgnPh3sBC1AR0VNgOgXnJ3864
         DbhRToGPnqRhc8gVXXFfK30mBqZq09suTdn7JjDYp7JxA1WqfSUEkFK1qbbePw1KQjrb
         Ga/rDHh8/67j0iFasC+3Y/0p7wLdqn2tihRkL/IxiyNnCDyyQKheskx5obbcaSCY/FzM
         cqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124598; x=1692729398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0LBEq/ZB9sIsZY2ixET4uGg+0+u11MKT3Wxwnk/wWo=;
        b=VSMNMyqa7xrAB/1ClNduhUyzOXG5AKE+DAqoAjBq1ShFZ7l8DYepv045SVbgLJ+i1l
         3R4Yu9xeB5Cvu6XhSRUk6wvEgRc37yRDQq/dIOWMTd8r7Tl1cOvVikT5NfHTazZqa71d
         JA1NHpqfAvgRBMGzxH9kX57kobMct6vZ7XL0vRJFDwLrnjPTioRvUMWAZGKjGKkgAf4L
         r3DSytXmTIMCe0/J4iDTTn0Oys7hsMJ0EhvzimGkF02cTAQBhWvCOvk+P7WoYOpQhoQD
         YF5MotY4jkptfUFS5D3YN6HgxYp5EepLXv+OeDqhlaTp+G1Xkw3uFZYK/3EtV7827rjF
         7qgg==
X-Gm-Message-State: AOJu0YzkknAFPIl8CFzRlvYqMTBRrbDJZAqULwXP7UOu/Mgrg7P4BSlv
        +b22adniRtFxqclcDLvVhddVRg==
X-Google-Smtp-Source: AGHT+IFlImEaAce593BX8IwDyQUyJ+yZaLkkfMo+qUwrwld3KG1GU/iUTSSbT1de1ty/nGedGvQ43w==
X-Received: by 2002:a05:6300:8084:b0:138:1980:1375 with SMTP id ap4-20020a056300808400b0013819801375mr11401128pzc.25.1692124598251;
        Tue, 15 Aug 2023 11:36:38 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x5-20020aa784c5000000b006875493da1fsm10000809pfn.10.2023.08.15.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:36:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qVyuC-007hmo-7Y;
        Tue, 15 Aug 2023 15:36:36 -0300
Date:   Tue, 15 Aug 2023 15:36:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "St Savage, Shane" <Shane@axiomdatascience.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: infiniband-diags can't be installed in Fedora CoreOS due to perl
 dependency
Message-ID: <ZNvFtPSumuXfOLZt@ziepe.ca>
References: <MW5PR07MB93324BACD6F70B9679E996F9D211A@MW5PR07MB9332.namprd07.prod.outlook.com>
 <20230813103305.GJ7707@unreal>
 <ZNpJCGSi7Ei1IN0A@ziepe.ca>
 <20230814182038.GA22185@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814182038.GA22185@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 09:20:38PM +0300, Leon Romanovsky wrote:
> On Mon, Aug 14, 2023 at 12:32:24PM -0300, Jason Gunthorpe wrote:
> > On Sun, Aug 13, 2023 at 01:33:05PM +0300, Leon Romanovsky wrote:
> > > On Sat, Aug 12, 2023 at 04:40:57PM +0000, St Savage, Shane wrote:
> > > > Hi all,
> > > > 
> > > > Just wanted to report that infiniband-diags cannot currently be installed in Fedora CoreOS because the perl dependency is explicitly forbidden.
> > > > 
> > > > https://github.com/coreos/fedora-coreos-config/blob/testing-devel/manifests/fedora-coreos.yaml#L170
> > > > 
> > > > This is a bit unfortunate because it also prevents usage of all the non-perl utilities (ibstat, etc) included in infiniband-diags.
> > > > 
> > > > Would it make sense to split the perl utilities to a separate package infiniband-diags-perl so that the C and shell utilities in infiniband-diags can be installed without the perl dependency?
> > > 
> > > I suggest to remove perl dependency from rdma--core.spec and install
> > > perl-dependant scripts only if perl is found on the system.
> > 
> > That is not how packaging is supposed to work
> > 
> > Everything should be installed always
> 
> Isn't how we use some packages in pyverbs?

No, just the test suite which we don't really package as an actual
binary

Jason
