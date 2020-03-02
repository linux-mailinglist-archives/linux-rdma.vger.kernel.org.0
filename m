Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266B0176314
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 19:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCBSrP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 13:47:15 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:38258 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSrP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 13:47:15 -0500
Received: by mail-qk1-f182.google.com with SMTP id h22so726787qke.5
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PtuIEjcp9lIt/PMRpntDNMTljv+59HZ/c9ye24RyIi8=;
        b=aq8TF0gJKZfhTyFwE2qNKiMOUMFdoV1cIqCjbBtFNjQYweRzgVlbgvcl5OY2MjtjHF
         kZEs5xaxGp09bBTwlywliUtSx4wrGMP2T755FDqTy1y3XgV7ZAhYEKftJgWbF3ejgWQ2
         jNg+bn9iTb1v3xVcbPG//Szx77ON9+k33znl6Fb/Vny5pAWywRnKARFvccN86zgkBox9
         lYBm5O8rfTJcMgvei6qunYfTzVWK2qtLs4KLontcqiTzmJa6yMJfkETwCp9k3rXwnv4h
         IxvD2z0e5k18YlY1OhXiWl5UUewqTKb6J6b+khvqOWadeTP8fOmTGiOmAx5fwCXxQiED
         uQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PtuIEjcp9lIt/PMRpntDNMTljv+59HZ/c9ye24RyIi8=;
        b=lmUvv3BieZJM57uqKNmXd0jowMqwGKEnIAaK6GngMsV3+GfQgyEg+Mn64u9hCAMMw1
         GXdHs2tRres3BFRuCVH/rYaQD67zP9IvP0GdGwsJn96qRt7cCJCaityqpG42NZ/WrXbA
         YFkqV/QNttSqlT87hCnerBdg3FFvlAhT+Wa0Fb2LOPcFBmZKj2CpXZPsyEdWffvkbPSk
         w7hXsGfNncAaKXih5ZB82aAsKMIIUe0oMUu04023xLEKOc9Qi+4F1KVgDSjPdPmrD6m+
         +OjRDW6q0PbhkldsnH+3tyjth7tA5tD4RWPMd/O8aY7FIGz25VKJzM+FBMWErKMyPSym
         /KZw==
X-Gm-Message-State: ANhLgQ06wuHsEpsS1ulol9D+oDg6I5lUO5QiNYF4pJyPx5kpgQEwDWyk
        V33+G0Kv3mxVdeboGai+WgQdmnGWDa2xbA==
X-Google-Smtp-Source: ADFU+vuJ31BqCK0wlw6ysTrd9bxp8nGL39yS1LnZHqAC4+Sd69EBBHUdCrW5R1aLjx/jfVZpPB8xsg==
X-Received: by 2002:a37:a87:: with SMTP id 129mr619608qkk.270.1583174832951;
        Mon, 02 Mar 2020 10:47:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m95sm10706250qte.41.2020.03.02.10.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 10:47:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j8q5v-0006e8-Qk; Mon, 02 Mar 2020 14:47:11 -0400
Date:   Mon, 2 Mar 2020 14:47:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Positive or negative error return codes in rdma-core?
Message-ID: <20200302184711.GA31668@ziepe.ca>
References: <7CF6DD61-B611-4C24-98CA-5ADCCBA75553@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CF6DD61-B611-4C24-98CA-5ADCCBA75553@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 09:43:03AM -0500, Andrew Boyer wrote:
> Should rdma-core providers return positive or negative errors?

All providers must follow the manual pages.

If the manual pages are unclear they should be fixed.
 
> The siw version of resize_cq returns -EOPNOTSUPP, but the dummy routine returns +EOPNOTSUPP.

siw is wrong:

# NAME

ibv_resize_cq - resize a completion queue (CQ)

# RETURN VALUE

**ibv_resize_cq()** returns 0 on success, or the value of errno on failure
(which indicates the failure reason).

Jason
