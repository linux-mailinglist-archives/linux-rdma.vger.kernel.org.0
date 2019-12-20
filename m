Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED342127BEB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 14:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLTNrs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 08:47:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41727 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTNrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 08:47:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id k40so8218155qtk.8
        for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2019 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q6GyF0QcTOJsUW+37VpjrWotJWCHXQwH4nGmsUY28S4=;
        b=Wje4NA+I0loo/ADCzzVPBusWP6DiLDcm24fqVi7+SZWZxgJkPWTyUFH/THRV+BwIMA
         yFB2PM8ADuRyAwSJJAkz548QVSmWb1A+uXSiXd/Kr60GHFK1gf3u+xHnEnOG7zpa6n8a
         1ydZM4pp9eC0l1fgoxLzC/nQ9BQ4Beq/loOsafYGyjPaH859DkpJ3g7brjndqXJTLRAz
         XiiOpLFixIt9BowfCwSkrmHefdoHh6CTFKhn2V3FD93uTa9BWMZ5h0IIQY2NR2ee77ER
         f/zqEEuMiE2c0o//jJ5r3EFwVQRmFo3vMc4BlcXZkA1+BYUN9YnRqeWk44ooLCUnBiCB
         EL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q6GyF0QcTOJsUW+37VpjrWotJWCHXQwH4nGmsUY28S4=;
        b=l1G7AmPK0dfa7OHBKoZbR1WPbIPjEKFrdseje3jq1Tkuj8S78t4RAbQ/yEDfUP5Z1R
         eRdSbmHD0ywnzTlTWchoE2eG0W5xRnXJ90ie+NHt/VQN6HYstbFMWZvfTB9vUIxvqObd
         15e+9NMF9E0o7o29z21Z9yML3Qc5q7FhwGQhV1a1mcFJ9h6x9cuPICPcTgxcMbhkKxqL
         X7NTpw+zMY/pBoGnrBFvfxmmdI8T7RGKSDuR8w7pzt1mHrHoSUw2VioOBAFdxA5BEkLJ
         MwPsIMYp7GdcZ6Ty85AIpeHWdVtKwoPLZmfWn5wX6YmMuREr+avuWiHTKrAqItvjb5V/
         Pr9g==
X-Gm-Message-State: APjAAAWDUKel9Boa1xR4fguNGfizFCuyf+/yWzXWTGFGyuXM2tViTg1p
        YLLLrxuFyKgW3tD7EJNedurPlA==
X-Google-Smtp-Source: APXvYqyUC07HcIR+VcneRTOyaRRo1PO6O4VpNIi81m9oCayPyW3zc+6n6LlCNGqlTrPo6/IS5cTyMQ==
X-Received: by 2002:ac8:5442:: with SMTP id d2mr12101119qtq.297.1576849667421;
        Fri, 20 Dec 2019 05:47:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t73sm2881828qke.71.2019.12.20.05.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Dec 2019 05:47:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iiId8-00040V-7H; Fri, 20 Dec 2019 09:47:46 -0400
Date:   Fri, 20 Dec 2019 09:47:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/4] Patches for 5.5 rc
Message-ID: <20191220134746.GD13506@ziepe.ca>
References: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 04:19:15PM -0500, Dennis Dalessandro wrote:
> The first two patches I wouldn't ordinarily have sent for -rc but I noticed we
> did this in the previous -rc post, add an API because we use it in the next fix.
> That's what the first two patches here do. It's understandable if you are
> skeptical that those are OK for -rc and in which case you can drop and we can
> send for next.

The only one that looks RC worthy to me is:

> Kaike Wan (1):
>       IB/hfi1: Don't cancel unused work item
> 

> Mike Marciniszyn (2):
>       IB/hfi1: Add accessor API routines to access context members
>       IB/rdmavt: Correct comments in rdmavt_qp.h header

How is correcting comments a needed fix?

Jason
