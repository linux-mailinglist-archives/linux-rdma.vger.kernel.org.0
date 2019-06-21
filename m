Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84DC4EEBB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 20:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFUSUa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 14:20:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40644 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFUSUa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 14:20:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so5117982qkg.7
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tDnbNM0YtpEmZhgKLsCHQoyLLtPRBtCwQNCrol8kJpg=;
        b=K2R4XPnjgohF1y+m/nuLS4ocTnSdYma1GY2/Kuz2Y37+INPSPRSX0X3RlG7BvShBXw
         pcZ9si9TFQ+TotFXh6SXfbBta6IfDlkc9qwBe++wA4X+e1AodWlkSaoqyv9eKat8Le54
         bZvDwWBYY93MfO5bGVR8FbtQpZgCiSPc43TrDzIZYZBwf+O7LL9Iy+n9GRXn8ih1FVPQ
         OCaz9GdfpVYNhF4Wh7wd1ktcxAVh6J3y5YNXqUa95EwUroOWrpgKjJH15ui2EDjig7B+
         RqVxq2uuVsmGIHrZmWvfloHWuYKFDTN9qIAVmVXgV/MrdkjkgaXmcmNN36jtavc+jB12
         4SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tDnbNM0YtpEmZhgKLsCHQoyLLtPRBtCwQNCrol8kJpg=;
        b=PDGY2QRdcCPUbBjxe6YwXPDfzMprXW4XQi7uawKs9YsrupFQmUV8yY/WkPiHiXJxlR
         t+ms7OyqOEptIOYRj6JyNSYNDlwYBkmN0AkMonD2uem2qc8D9I11z6F1m/5jVy54kxGH
         t6sYFD4137Vziq8OESYiSBsWDyjZAy1Ov4hnL8/2anDZ8cIPBuL2Z3rVA1gZx63ZsfCS
         7VeRNR6Gn2HuGlXRx89VgtOu0WtjjDzLaGN3BxMHTep0IlNn8r1jueRgwmDt3LvfV9xE
         km5rH+3aiwh+E20M0xSK0/ithnCc+1z35HOEiC1A6v22syORwnC2LLBenTZltHNvQ2li
         da/A==
X-Gm-Message-State: APjAAAU/PGZBjB78BZP5eeM0pQRpIp088W7OH/kIuaU8Bv1ugEmCwRVE
        AtTb8e37gdJNZ9BCLMxCa79zkg==
X-Google-Smtp-Source: APXvYqzVRHnweippc+/MvmyiI5kKATs15sfVIFRtxbb9NxQXNDhEmOStQSIKFojHeAB6qak2i0/owQ==
X-Received: by 2002:a37:4b46:: with SMTP id y67mr68586171qka.66.1561141229566;
        Fri, 21 Jun 2019 11:20:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g2sm1637587qkm.31.2019.06.21.11.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 11:20:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heO9E-0005z9-GL; Fri, 21 Jun 2019 15:20:28 -0300
Date:   Fri, 21 Jun 2019 15:20:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH v2 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
Message-ID: <20190621182028.GA22934@ziepe.ca>
References: <b77fa93a0a34dc0ae40bdbac83ea419a0d8879ff.1561048044.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77fa93a0a34dc0ae40bdbac83ea419a0d8879ff.1561048044.git.dledford@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 12:30:17PM -0400, Doug Ledford wrote:
> For all string attributes for which we don't currently accept the
> element as input, we only use it as output, set the string length to
> RDMA_NLDEV_ATTR_EMPTY_STRING which is defined as 1.  That way we will
> only accept a null string for that element.  This will prevent someone
> from writing a new input routine that uses the element without also
> updating the policy to have a valid value.
> 
> Also while there, make sure the existing entries that are valid have the
> correct policy, if not, correct the policy.  Remove unnecessary checks
> for nla_strlcpy() overflow once the policy has been set correctly.

The above commit message paragraph is out of date now.

Otherwise looks OK to me, it would be nice if we could avoid sizing
the string in the policy, but OK otherwise.

FWIW this is probably how other netlink users in net are making their
use of strings OK. The policy will reliably trigger the EINVAL if the
policy length and the buffer length are identical.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
