Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C40754A4
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfGYQxT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 12:53:19 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:41638 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfGYQxT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 12:53:19 -0400
Received: by mail-qk1-f180.google.com with SMTP id v22so36943784qkj.8
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gl3eL8AXPiJjdtZEVIOL9Yh7v/UpLB9V/dFfbSsPgbc=;
        b=Xg0O6pUbZb5HsrgCG/bdUMAdkgNb/DTxJe9ikWOd4zaujM1qklEEGaCQixK6Sem4M8
         jwpepmBNRGoxAyEqcL3vMrpPppWTFjZPI86ya9sJEQO6ySkF9RlLcsDnFiyr/T2Pkbob
         AZHqhsxGFRqOBiF9NSAjmYBIHAz8x0eGYcKNRDpnu1Nexwtdd9EWJtBfx/+nh14Hgrv3
         TnmpbcXShbhRJaBhbgxTVjTPPIh32o7zuSTfzgjDTQ0MK+sRo5/oU/Pozos5n17hBayf
         3aJN83kjPGQKzL7NDnianDi2qpVdIPzKzLDdwdGT2D69D9lJCa/WFcYpRvjlQN5Y8Eie
         jBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gl3eL8AXPiJjdtZEVIOL9Yh7v/UpLB9V/dFfbSsPgbc=;
        b=CfrJ+OuCV7m6476X4/6bpOWVdbqZn9q7Xa13oJHKSUdWJQwDe1zmx7+6FhaoUDnkym
         7Qeh/1XAhUtUqRpHH5yMefSCr5Xb3b5rUBU+67Cun9aDxujD/SxKHTQW4wsvo8uf0MAn
         dGm/EHL9v1PsEOeCczl3EHYDwo9EwTXvV/UZryqs32qf5FXTHvFI4vwmXjZzUooD5NUQ
         7IKaXXLVcVjW2i2/kZW91ZR7ENTCHQnK/7u+AqugPIFcvp7ZP4F9y8u3MyAuDfzYaLnj
         mUIchlU+lWfyPHXDe97zNerfh3ROFM1gk6pEsS9/uu+g4brwM7P8OBqZaMLuf2XVAPWd
         CVdQ==
X-Gm-Message-State: APjAAAU2XPXM9kW4nSDgLBAyI3Cj2UvdYkYW7/SThqr0QxOIy1354G2f
        L1wT0XzHyT7uqTYjvDa4/3iQ4/Fj3wNhEQ==
X-Google-Smtp-Source: APXvYqzJlnq4o1Um56bH1aNWjbLoRekBOpiJnEMjWtAMP6vqDUkFB9J0Voj5D+T0fKkKwJ+tdRyfdw==
X-Received: by 2002:a37:6ca:: with SMTP id 193mr61921318qkg.389.1564073598249;
        Thu, 25 Jul 2019 09:53:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r36sm26589750qte.71.2019.07.25.09.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 09:53:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqgzU-0007E2-SQ; Thu, 25 Jul 2019 13:53:16 -0300
Date:   Thu, 25 Jul 2019 13:53:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Honggang Li <honli@redhat.com>
Cc:     bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: Re: [rdma-core patch v3] srp_daemon: improve the debug message for
 is_enabled_by_rules_file
Message-ID: <20190725165316.GA27749@ziepe.ca>
References: <20190715041614.27979-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715041614.27979-1-honli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 15, 2019 at 12:16:14AM -0400, Honggang Li wrote:
> If the target was disallowed by rule file, user can not distinguish that
> from the old debug message.
> 
> pr_debug("Found an SRP target with id_ext %s - check if it allowed by rules file\n", target->id_ext);
> 
> It implicitly implied by the message next to the old debug message.
> 
> pr_debug("Found an SRP target with id_ext %s - check if it is already connected\n", target->id_ext);
> 
> The improved debug message will feedback the check result of rule file, user
> no longer needs to wonder the target is allowed or not.
> 
> Signed-off-by: Honggang Li <honli@redhat.com>
>  srp_daemon/srp_daemon.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
