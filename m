Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412AC2FD9E5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 20:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbhATTmP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 14:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392703AbhATTlf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 14:41:35 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2082C0613D6
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jan 2021 11:40:50 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f26so26502470qka.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jan 2021 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SsIFWven+THPI4KISVXP4D3Yn9JKU0kYSe00HOBlua8=;
        b=GR3xBxSQRAI/lYBt6AaRdopILf/kPv1D0W/lJRvNpSyj8QffuNYw+rv1G77z29e9py
         fN7y863eWuM5RrDeTCwrkUqw7Oh3klepAeC9sCL+vlJaa3XmRKGOL9k3vLOnseJm9+mA
         cxh0X2Hpe+pSPl4+eU/h5e9jL0EPyy6AWsPcNX2h6mm2ilaa9aU2bxC8M3X6nz7llb3O
         TQncFjN1BYAveoGxhbU1I4mIgfdJcj29qwVZdp6POM1DMC333g/tt68+aXZDpybFP1Si
         2cXsw5usIEi7Z05nN7S4sSj5HzlrvwBurJCLyzeHi6kEcPv54BZYjRetLA3HQTWu9yP2
         mT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SsIFWven+THPI4KISVXP4D3Yn9JKU0kYSe00HOBlua8=;
        b=d6DNUB3DwlLEZOhG/r3ixLmW8Tmm6Aw3mRNRgAzfnmT8xuFA2YLxUqJQoLIL/f6yT4
         35/fpMW7u0ToLK565cQgren2HckA3RUKEby1J5FrLTpWG2Rl4Y25M1bjHbXVhxtfQCKN
         xSuC3VAiJthXhl99ILR1s9ixE6Og5SiU7g2JPFhs9gbeuJrM9GFYks1/evTQli4TUmAT
         j3ZU3nSxmoLchKlbfmVFef5NJPAh8ubvWWufPMKVd+4tMIYei5rj9Ef+Puv2bqgGB0EP
         4vprB5yqfNmBKtw3jYI79US7E0A44sGkyprva1RRNPvpsPHY689j4z82AbTmMwaZMhIQ
         gHAg==
X-Gm-Message-State: AOAM5309n1nOgCMZDHlcKlCb7FJzGynYJMLlJArM0tZTrmuJ1kXvTQDr
        azX/qw+YN1aZWnjuLJzuBV83ZA==
X-Google-Smtp-Source: ABdhPJxB7Yl40gKdLRPExcU76R9plrdY1yJeEKsejrkwDLDQZYTvdbVFE0mlQiiOo8+Te+DnKDqW3g==
X-Received: by 2002:a05:620a:713:: with SMTP id 19mr11211529qkc.424.1611171650065;
        Wed, 20 Jan 2021 11:40:50 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r17sm1787533qta.78.2021.01.20.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 11:40:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l2JLU-004fCt-B0; Wed, 20 Jan 2021 15:40:48 -0400
Date:   Wed, 20 Jan 2021 15:40:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Fix bug in rxe_alloc
Message-ID: <20210120194048.GM4605@ziepe.ca>
References: <20210119214947.3833-1-rpearson@hpe.com>
 <CS1PR8401MB0821488ABBCDC7575CC237ABBCA20@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB0821488ABBCDC7575CC237ABBCA20@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 20, 2021 at 06:48:12PM +0000, Pearson, Robert B wrote:

> As far as I can tell the RXE_POOL_ATOMIC flag is never needed and
> can be deleted. New objects are only created from verbs API calls
> and never from interrupt level.

I was wondering about that.. From a core side only AH's need atomic,
so why is this on a mc? I guessed it was some internal rxe reason

Jason
