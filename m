Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282231683F4
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgBUQrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 11:47:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41424 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgBUQrl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 11:47:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so1704461qtr.8
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2020 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fYhkpGecs/Eme/4TjRbhNljoMlaZSssgdEhq3g5wpcM=;
        b=FUY/VXOQN9gph/EQw99S4cr9KWRkDEJwx1xPOVFEoWTh+WvGb75qCN+hAok5GdSZge
         OGCeKVbbPKRr6LhMBQvAy6NugBh4ZaQIA6FqJMPFWyi1c0g9y7G9pThGi8aCz3AtyV8t
         1Gr8+Vxrs1fSqku6C8MxlZ5Ktz38hBWI3tznPJTx7q1dNqHjBUJlzDOPoEaZ4MxQmdmO
         1MQRRqHH9ScVyPJP0hf8jfzxn4QklmPXKIhj+V/CGq/pJgMzd1/1gvlvtM15MdkFrGFB
         O9lITJffhjdsi8HkNedX1M8vSZNHQGSdFGDZMqC0sfD/Cz9AmikbbsES2IykwKJkul60
         B9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYhkpGecs/Eme/4TjRbhNljoMlaZSssgdEhq3g5wpcM=;
        b=XWntwNa2s05uWDRI7k/cwHlhj3D120ihMPNGheXbTZEO8Qw+ZehOyKiKDuja77yPpw
         RUo7nO10JvjvmFZiBs3qtuu0PCEcXBTAn4ApQCc2ITeCe+scLywSjFoulcUzM8/M7Oyf
         mEuSr6HN9kFHyDpWrxZpL/WlOCsg+mn8BVZpdEMTsU0LIpV8g1aPU29aQG5cY44dALo4
         aA8MOW0yoYeqWVuo0gxlKcZWcRtjL+R/X0g++ErVb17wVKB8sX90Y1ZpXeqlLw0JZulg
         MM+D3tbLCHQsEtNgOYJKtLnkeh/y9npJg54tF/KJLheflXBOKqAd2I0rOt71xR1PKH9u
         1EJQ==
X-Gm-Message-State: APjAAAW5L6lFJHfqNQF3edJmR/1zXaOj6FBRYWpkCsy10vAw/d9D+Vju
        KWN7C/dT6ty/G2V5nUQc5nObtQ==
X-Google-Smtp-Source: APXvYqzzDTW+sq25vjpoEdfxg5Ptznyr9g3WJl2AxbAZbXpcTNW23eICg/3gPoNWKBYEdUPPQLWJbw==
X-Received: by 2002:ac8:1e90:: with SMTP id c16mr32515464qtm.265.1582303659206;
        Fri, 21 Feb 2020 08:47:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b7sm1774351qtj.78.2020.02.21.08.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 08:47:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j5BSk-0001j7-6D; Fri, 21 Feb 2020 12:47:38 -0400
Date:   Fri, 21 Feb 2020 12:47:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/providers: Fix return value when QP type
 isn't supported
Message-ID: <20200221164738.GK31668@ziepe.ca>
References: <20200130082049.463-1-kamalheib1@gmail.com>
 <20200220230138.GA3489@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220230138.GA3489@kheib-workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 21, 2020 at 01:01:38AM +0200, Kamal Heib wrote:
> On Thu, Jan 30, 2020 at 10:20:49AM +0200, Kamal Heib wrote:
> > The proper return code is "-EOPNOTSUPP" when the requested QP type is
> > not supported by the provider.
> > 
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> 
> Anything blocking this patch from getting merged?

It is tricky to check that nobody is reading the error code this
changed. Did you check it?

Jason
