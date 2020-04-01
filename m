Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4219B72A
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2020 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbgDAUkp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Apr 2020 16:40:45 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:34615 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgDAUkp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Apr 2020 16:40:45 -0400
Received: by mail-qk1-f171.google.com with SMTP id i6so1615261qke.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2020 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VT/2IM5shmAIxa3mrvoHcYuMQA0eiOoWwc6/iOS1kgo=;
        b=MRs/nfX6RuyYIrvjoncHDgzrwPJsQEIUHBeB3pWA8iWge8kunRPJSl5WGdHFOmifEU
         q9aZfwArOuEMo6fcGR5wunrVZ/XJs0gzVTYkv3T52i9bAfG2kDxUPitMRGygL62NnzJN
         8/fakWKBjwboGluaug2sE5r0B+T+BIMwKcRdPBjlcdzqOwcSvgSA8p6IMfqh8KajUr0U
         QF+w4UsGpkt0twZK58g520Mg2hgXa9+M6AbfWBVqB0eQw5Rks9zunLKQrDy5aVlHRcTw
         FqkFJxsE7B2src/t9qBYBL8q9gcu6jFDKqmnMf6cYaWbW4HmEhWCtRupdEDqbnCcQwQj
         sQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VT/2IM5shmAIxa3mrvoHcYuMQA0eiOoWwc6/iOS1kgo=;
        b=pwwkvrKypCvBgzWjTKxQU0EEO/10FxITLYlKuz3Gzm9biklsFODnLMkEMkKj8B5VC3
         /5IFrmYoRLoxve3QDeeaa7rWR1KcpKuI/EjOwTNOX8ykJEAEL63HIpoK8RotQrh4ruG0
         kbxhCsX7rA3LpIHwCUdLuszCoRv5BAM5DRNIHW74iCW5zo1sAOtjrsSpj+Zx/l/DDxzB
         ysmBEEHDMuqqCX75Q3abEVGGv49dDyerzMufoivXXJvSyKCCZ65inIEqNxkojSX+Ol/s
         8Gi4Bq3LXWRzFfI971mb1OGB5bHsv4qb5ibbGAfFctIoXWVmioFulRHthm0yczO8g6db
         3MdQ==
X-Gm-Message-State: AGi0PuYGT1CbMdnJ8e9fjEi+i4OLJdBldBrtlJumIk2ZnBX4roaeYmNJ
        uyryRPedcatthMLhx+E2uphy0mCSUGkgzA==
X-Google-Smtp-Source: APiQypIjPqoAmi9KmgoJ2TLCakSuLYI6ybUU52WNG/W4F2D2AyOoaFRYnWmASKmdplwghEPZHEYGug==
X-Received: by 2002:a05:620a:1084:: with SMTP id g4mr180782qkk.52.1585773644583;
        Wed, 01 Apr 2020 13:40:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n67sm2108431qte.79.2020.04.01.13.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Apr 2020 13:40:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jJkAF-0004HE-DL; Wed, 01 Apr 2020 17:40:43 -0300
Date:   Wed, 1 Apr 2020 17:40:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Rehm, Kevan Flint" <kevan.rehm@hpe.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Delphi <delphi@cray.com>
Subject: Re: updates needed to Documentation/librdmacm.md
Message-ID: <20200401204043.GP20941@ziepe.ca>
References: <EF5E5EF5-3F38-4405-A01B-3DDDC89190BC@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF5E5EF5-3F38-4405-A01B-3DDDC89190BC@hpe.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 31, 2020 at 10:57:05PM +0000, Rehm, Kevan Flint wrote:
> Greetings,
>  
> Getting multiple infiniband interfaces on a node to work required
> more changes than the hints provided in Documentation/librdmacm.md.
> We have a few suggestions for additions to that page that might save
> others a lot of debugging time.

You must have some very strange configuration to need these settings
changed - this really only impacts cases where there are multiple
interfaces with overlapping routing.

Generally the default should work for unambiguous cases

If there is overlapping routing then you need to follow the usual linux
guidance which usually also includes policy routing and the various
ARP adjustments

Jason
