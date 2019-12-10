Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2F118F02
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfLJR3u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 12:29:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45372 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfLJR3t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 12:29:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so16191567otp.12
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Om6tE+FvZ/QlLF3OwltpzrngNEaQnt3vJOlQ93C4m64=;
        b=X5KHtXh0QhARWqNc7oZKkCtpM302AI3x236TqVOdyrDAwer0wyoLxAXUSgzLPoQa5j
         iEPDfRMQONgr8WVNLuLyHGeBK1HecCKBXJ4VOUQBsdZAtvN7XfZazcqsOBPBXsOdmTuk
         DAmFKZjhiNdrRS9s8Q26mJGciMz61yWgnVfjiFotUZ1G/78D1m4Kn+0hkoPZQPhSyyXk
         4q3t3erGIqjZ654J0o7JD6U/xbwVZlinwAbMZhG+3+2bXGFYWiiGSh/1CGqtfLRlbSBc
         T2DupYl7cYkX7teoH5cHNlBmkeMvsX+aUatO/dmXhmSsKU+5c62n8/WYnOJkgeMKJMmT
         Iypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Om6tE+FvZ/QlLF3OwltpzrngNEaQnt3vJOlQ93C4m64=;
        b=PuWCVtFLGTJwzR9Pk0A4lZ2kMmAkHnIyqxu1Gdno5L5peKrBRcrUt/R5tBNhHAV1xr
         2GCRceY3vWNI+zOo2W7UeJpHg9YXKjnZIYaWHduXAGnDRvRwP9o08Bfbw1kFgZOjgHvj
         Qjv90MdgfuYb9PcOrgpwxtHBMiBWxs7HvxETBD3t2/qfIf2T3ihUfYcbEfyN1iltInYy
         ZLWSkAQGT17tLIxqNImMo8hDhePFjepEeoodQD+639LlKOP/EHKjXlj/iWL99OBehOYO
         XO4UUrUkCKdgmIby1IFa3m31rdkrzNNL0PDZGUc9sTLZG7aJbI0e+cUOWQrxJAydi1rn
         YL4A==
X-Gm-Message-State: APjAAAXNqXdNXJbaoCTWaG0nZIY5+qC5fUeHj2zg+XkDMceKC58cf1S/
        jxcTlE9nBamULw2drGMEjDCfTdkTtkoPAg==
X-Google-Smtp-Source: APXvYqwXjdC+ZOleq+T0ViyThz4HOYEB5igZDnWaIgTsVpYeqKR1oaUeDAnf9+fmPXp624zx7UwBxA==
X-Received: by 2002:a9d:3b23:: with SMTP id z32mr25223181otb.159.1575998988806;
        Tue, 10 Dec 2019 09:29:48 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id p24sm1578151oth.28.2019.12.10.09.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 09:29:48 -0800 (PST)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iejKV-00001B-Kd; Tue, 10 Dec 2019 13:29:47 -0400
Date:   Tue, 10 Dec 2019 13:29:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thorben =?utf-8?B?UsO2bWVy?= <thorben.roemer@secunet.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: install-step fails for pandoc-prebuilt man-pages in
 infiniband-diags/man
Message-ID: <20191210172947.GB46@ziepe.ca>
References: <5d754108-7020-6041-1b7d-bbb3fb2f089b@secunet.com>
 <20191209193936.GA3471@ziepe.ca>
 <1602a0d4-4849-d9a8-2123-852966815cd0@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1602a0d4-4849-d9a8-2123-852966815cd0@secunet.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 08:31:20AM +0100, Thorben Römer wrote:

> > and yes, the no-pandoc builds have to use the standard paths.
> 
> Is this documented somewhere?

Generanlly the no-pandoc build is only for some old OS's. Most new
OS's should be installing pandoc and avoiding this flow.
 
> >> With my limited time and expertise in the rdma-core project, I was only
> >> able to come up with a solution that I don't find very practical. I will
> >> append a diff of pandoc-prebuilt.py nonetheless, which replaces
> >> hashing-calls for *.rst to *.in.rst if applicable.
> > 
> > This just makes broken output if pandoc is not present, it is not practical.
> 
> The diff just changes the filename from *.rst to *.in.rst before hashing
> (get_id()). pandoc/rst2man are still called on the *.rst files (NOT the
> *.in.rst files), but the filename is now based on the *.in.rst-file.

But the scheme is to store the *output* of pandoc under the content
hash of the input.

So hashing the wrong input means you get the wrong output.

The hash *must* be the exact input to pandoc and rst2man.

> > The only good options is to shift the substition to after
> > pandoc/rst2man run - but I'm not sure if that is doable..
> 
> To my understanding, this is basically what my diff does (although it
> does not "shift" the substition, but rather just uses the unsubsituted
> files to produce the names (hashes) for the prebuilt documentation). But
> as I said previously, I also do not consider it a good fix for the problem.

The shift is essential, if we retain @CMAKE_FOO@ through to the nroff
then we could do substititon on the nroff output and everything would
work sensibly.

This seems a bit hard, but is the right way to make this work.

Alternatively for your use case it might be more reasonable to copy
the pandoc prebuilt files from a system with pandoc, that did a build
with your desired path, onto your system without.

Jason
