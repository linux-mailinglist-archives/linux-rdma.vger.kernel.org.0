Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9521AE5AF
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 21:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgDQTR7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728260AbgDQTR6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 15:17:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA3C061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 12:17:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c16so2962069qtv.1
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Oi42cOfLbaOjiiRpWir3gqYxnlbkTfrUk82hw110P8=;
        b=U3w3yUuRA0Bux5GTafIWqYUkz3yptuzj0D0nw0MYWA6Lbd2685UTEL2bKTUB3h/fCM
         oR0Z0ZcnW7oz4b+T4aC5dLxQIhCPnKHuCs1H+dw4BV46AkYzVayJ54SRfrk7Z0yu44Jp
         euYU1f8P+R3Gf1/yOTiW01m6txdp29AcDcOro8Ym/gAIVeHhslaQ0ik//V+YnLjO5Mta
         L2IbZgDXgAF8fE+1ClVRPlklcyAsuaEM4b/gMIPBCLdfWsjeDOg9Q2EkhkM9H4ITnnMS
         pmZt8ynfu/2w+v8E69vX10gCFrPej9SN9cJh3h4JdrPmxGUv1YhpNWYqwzk98u1n6evU
         dYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Oi42cOfLbaOjiiRpWir3gqYxnlbkTfrUk82hw110P8=;
        b=jCHn79HfEiYjb4xA090zV3HlAVIk3dXp/I3LDuhhrlLbvr8QAS1LKrEpiYYcjCwjKv
         Vqy2h60i6TkQzSsP6W7/HMUCATXKI4ib1Dg47H+rCFV6lQ4m0P9O8QdFCEhS0rLVLvvX
         shPjBnnnYHbngN0P+/kzeV6BWWwMuiSRrk+DLRxZ3Ni0STiG8KxdYQMoaqlmrH314S0V
         blbaOstLT03OojqddIEuRGVgHEqvxFkfiEYWKJStXsRqJw0agFBK8XwWvEjQ5F0R1AiP
         RECt48VHitUIY2p5DzspuL6blCGNeur3OvzQTvKJ1aH5J+onabe5jv3lXe1u5Q55AtXa
         +Vhg==
X-Gm-Message-State: AGi0PuYinhPljGVusBA/DmWQ/u/KokyW3YnXNJVYFIieq7/V0APtipUr
        xyQ6zXzLUFZXRLb7yOqxZhNv1w==
X-Google-Smtp-Source: APiQypIqdiX95PWlLYsNoy7N72z+i+xgzUdtRqmi2BW7GjCcsIRtlp1po486Xo3o1K7kE8HFuYt2aQ==
X-Received: by 2002:aed:20e3:: with SMTP id 90mr4570092qtb.142.1587151077333;
        Fri, 17 Apr 2020 12:17:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n10sm16675337qkk.105.2020.04.17.12.17.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 12:17:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPWUu-0004hn-9k; Fri, 17 Apr 2020 16:17:56 -0300
Date:   Fri, 17 Apr 2020 16:17:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        Dave Ertman <david.m.ertman@intel.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>
Subject: Re: [net-next 2/9] ice: Create and register virtual bus for RDMA
Message-ID: <20200417191756.GJ26002@ziepe.ca>
References: <20200417171034.1533253-1-jeffrey.t.kirsher@intel.com>
 <20200417171034.1533253-3-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417171034.1533253-3-jeffrey.t.kirsher@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 10:10:27AM -0700, Jeff Kirsher wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The RDMA block does not have its own PCI function, instead it must utilize
> the ice driver to gain access to the PCI device. Create a virtual bus
> device so the irdma driver can register a virtual bus driver to bind to it
> and receive device data. The device data contains all of the relevant
> information that the irdma peer will need to access this PF's IIDC API
> callbacks.

Can you please provide examples of what the sysfs paths for all this
stuff looks like?

Does power management work right?

Jason
