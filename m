Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53012A83E3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKEQrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 11:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgKEQrk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 11:47:40 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13AFC0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 08:47:40 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so1762063qkb.7
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zhqw6nXW7an1sciymnqR0tpduOyD+zat59s5GBmVtbM=;
        b=T/9h4B64oiALMfc42uebDeGSEyGeD0JwaqBLLTEWSdW7X4iF0nNQTGD8ItXWOPi1xM
         DOvW9K/135GnWww5roe4BdwNCigRiUCwRDf4zxYgylBvKtGQ0y4XU2iCE2XUZ07ICn3L
         rTXg0XPkpw/UUFWbC8Cig/5dZdORb0CzNbOAohUH2HvpxEPnNWIhHQhklANJ/hAkg8H3
         MKb/DtGr/YW1Na1efMq3URRzjr/gbNFdmBokrf0ljC1HCRvWFNeTvkJMTB7Vdi6j+NUo
         8K7nKdD6xanzOWR6UK32MPYw28AHa+zQYvDZXAfI7cRkoGcIsjwKs0OHgVNNYy/123gh
         Xm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhqw6nXW7an1sciymnqR0tpduOyD+zat59s5GBmVtbM=;
        b=mpPPEESBosFa1sMQQsxno6ckaj9YWrhwCX9W9x0UjfncXWj0CS9oYTp2mcKFINh6/i
         nt1irpQcjdg5kbk2DB6YX2h7FV44kQFkU1W8tavNacSYJVwnws513XKtU8ZnhI9hIEWi
         esfvET7z4vnq1E685KC/gt1AOIO3FAOPPVOOHCrnhjQ3lKi63KaeohFuk6Ey/QtVIHKJ
         46OcT8T3CuvC6tX9qaMbSVzhM3hZLcb2pnvgY4CSvtc5o7U1mEDWuI5I0YOpzRKVNAlf
         K+UvueFVn708yV3XL3+1r+i+mIHVRU1C8AoTnXJGrdcA9UMiPRYOIAqMzs79KJkzZhx5
         H6Ww==
X-Gm-Message-State: AOAM530tv8QMUQ1gPzgY+jm9lUx11dCndp+z8btHA411g5i+bHGvrOw2
        iBp/NActKBKPWN6E6kn9LxmrzQ==
X-Google-Smtp-Source: ABdhPJwzljYxFoBvKq1VFYeruz7gb+7H6oGN3WPy1j1HdsQNZAjc4YfzOlkNglv0PQR1cXTjqGzkUA==
X-Received: by 2002:a05:620a:697:: with SMTP id f23mr2825760qkh.374.1604594859867;
        Thu, 05 Nov 2020 08:47:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g20sm1208553qtq.51.2020.11.05.08.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:47:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaiQE-0007e8-Gm; Thu, 05 Nov 2020 12:47:38 -0400
Date:   Thu, 5 Nov 2020 12:47:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Netdev <netdev@vger.kernel.org>, Parav Pandit <parav@nvidia.com>,
        Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Patil, Kiran" <kiran.patil@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David M Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH mlx5-next v1 06/11] vdpa/mlx5: Connect mlx5_vdpa to
 auxiliary bus
Message-ID: <20201105164738.GD36674@ziepe.ca>
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca>
 <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
 <20201105073302.GA3415673@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105073302.GA3415673@kroah.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 08:33:02AM +0100, gregkh wrote:
> > Were there any additional changes you wanted to see happen? I'll go
> > give the final set another once over, but David has been diligently
> > fixing up all the declared major issues so I expect to find at most
> > minor incremental fixups.
> 
> This is in my to-review pile, along with a load of other stuff at the
> moment:
> 	$ ~/bin/mdfrm -c ~/mail/todo/
> 	1709 messages in /home/gregkh/mail/todo/
> 
> So give me a chance.  There is no rush on my side for this given the
> huge delays that have happened here on the authorship side many times in
> the past :)

On the other hand Leon and his team did invest alot of time and
effort, very quickly, to build and QA this large mlx5 series here to
give a better/second example as you requested only a few weeks ago.

> If you can review it, or anyone else, that is always most appreciated.

Dan, Leon, Myself and others have looked at the auxiliary bus patch a
more than a few times now. Leon in particular went over it very
carefully and a number of bugs were fixed while he developed this
series.

There seems to be nothing fundamentally wrong with it, so long as
people are fine with the colour of the shed...

Jason
