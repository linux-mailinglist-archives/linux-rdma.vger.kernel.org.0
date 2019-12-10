Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F38118FBF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLJSZq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 13:25:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39312 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfLJSZp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 13:25:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so16391135oty.6
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dCTL3YxjonYnGSDvN2t/7n7OmJ3ZoEc0YTZV/xANSbE=;
        b=fZJdoQ1tLXgEpQEXklPsQh2EaC4q7+7bxzhktLpN1AGeHNPp/eez///fvRyXpIJNcy
         A8BdR7XZQ0qt1PsHCP1VVAyTbysfpXjZT7gETKO2yFELTTcQpDcEh6qVBnHfm0ssPj8/
         Nd3I+mv23uGbw+9fXMzJIEIuZzkgrhJ2ZQJ6Zq7e1k8cFbCbGwEfbGo1n8zuHKJoJUOG
         USx6EdYnG33ZL7nUpVfRmlzNao7vh6ZcPix8L+rbGvCALLraB01MZB14vaEfvupwSGxe
         uqQkPcbloq8jSTIo/+tsUhswQkuGRH1OejP6HpEdnm3utgbO+jePjslTUI5OalOLhyZt
         q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCTL3YxjonYnGSDvN2t/7n7OmJ3ZoEc0YTZV/xANSbE=;
        b=GIO0JcYHwmIXtpA1q+70Mk7oHXX3X0TOndVL9jTURVt6cNFLDGT3snDPra4XkW+wRY
         5dzlledHIEX6Qmvv2n8avUOjRooTnXMvA4cq0f2HU5r9GdralfBVLOzsVjFHNHzUzBCa
         FYot9yJXu8Po0RdLpwl8eQjhJqZtAir1C0ba1Tg+YNVkSGQvmbkVgX+XVSwBYVYeIAHg
         1G1qY8wvSsI+ohagzUwNX+m2j0blUz8V67+dtEB9IAJ+PZ7jyIqXPAUfA9P30yVpyFTH
         ZQWmRfZ5MdcKXYcgS0Q6rVt5VrMkx5Wrmu1Sza7ft4Ewt0o967q+Prwk43MJKgmIeVbr
         7pJQ==
X-Gm-Message-State: APjAAAUxtNB+p6HbTfNDDdVnqsoLl/l3jNf7UG5Hyg+fEQ43PDR7li4Z
        /wj80Bi68pNYVaBgXZtLzplRIQ==
X-Google-Smtp-Source: APXvYqzVPNN9yv0gZxPeuvhMAs6KzLvZrIY6+h1YezEHRThj1WMoy11GMf0DyPigX3zMuWPn2JLYsg==
X-Received: by 2002:a9d:5c88:: with SMTP id a8mr23524797oti.348.1576002344965;
        Tue, 10 Dec 2019 10:25:44 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id b15sm1649465oti.23.2019.12.10.10.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 10:25:44 -0800 (PST)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iekCd-00001g-Se; Tue, 10 Dec 2019 14:25:43 -0400
Date:   Tue, 10 Dec 2019 14:25:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com, parav@mellanox.com
Subject: Re: [net-next v3 00/20][pull request] Intel Wired LAN Driver Updates
 2019-12-09
Message-ID: <20191210182543.GE46@ziepe.ca>
References: <20191209224935.1780117-1-jeffrey.t.kirsher@intel.com>
 <20191210172233.GA46@ziepe.ca>
 <324a6a4c7553cea5225b6f94ff224e155a252b36.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324a6a4c7553cea5225b6f94ff224e155a252b36.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 10:06:41AM -0800, Jeff Kirsher wrote:
> > Please don't send new RDMA drivers in pull requests to net. This
> > driver is completely unreviewed at this point.
> 
> This was done because you requested a for a single pull request in an
> earlier submission 9 months ago.  I am fine with breaking up submission,
> even though the RDMA driver would be dependent upon the virtual bus and LAN
> driver changes.

If I said that I ment a single pull request *to RDMA* with Dave's acks
on the net side, not a single pull request to net.

Given the growth of the net side changes this may be better to use a
shared branch methodology.

Jason
