Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD244D6ED
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Nov 2021 13:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhKKNBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Nov 2021 08:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKKNBh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Nov 2021 08:01:37 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACFC061766
        for <linux-rdma@vger.kernel.org>; Thu, 11 Nov 2021 04:58:48 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l8so5179136qtk.6
        for <linux-rdma@vger.kernel.org>; Thu, 11 Nov 2021 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7QOsMqCdGDx2uwhP47H+8Gm4cUkLMY7zPxk600SF4Bg=;
        b=jJB9Sy0CnHX7UeLSK2w1IhkdpYcUHLsCwgURvIiJWnjaXlNPkviAAH0/yF9eFBWTnt
         O02Rv8bTLvghtwivEqlhVWo1Vfyh87T8CQ82eC9MQMzIaSiqM7jFDnBkzp41td5YScnD
         G4jJyzZwwQWn3uFFP4oDgNEa/KmcxCzKOl8g+uaJpxJYOPZkR0pPZlAIDozaHC60X5GH
         u3QCzlu5N88+5HRy9dlU0cxVl3ugsnzlgWMVlmlro3BM4zxF7Z8cz58WEpVFv7K0hOFb
         WngJHw+jWAqsBuI/8lFRA+jQg8roJs4vLhuP9TaDHXIm8+eSgD5FJXOl553VRC70Jteo
         nK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7QOsMqCdGDx2uwhP47H+8Gm4cUkLMY7zPxk600SF4Bg=;
        b=mOJOzF6YLJbihRG1RJdaFSHF1pvGx0TgEW5Qfw87NSH9bQAHMtmPAr2/WPkzQBmhvY
         a4nPWupxqGzNRIfNnnlCgM1w8PJUdvvQclwV4absfWZSZ2joxJm0+cCAiSsH0uoEPU+u
         RGK+HA7rhTddBn7Mf8cxn7kP5l6Lhm0H8sfu7x/BS6O6DZN4b0SIEsDrZ5UMgDqdD3pK
         GcoB3xiYS4CPba9+gztliDWEDte3NPalnAdJpWawRRHzG61bF1N8hVN9RJoPO7Cj4wRi
         znDaPVGeBPa60kPRo7CSDKyXaeDbpxKj/QvSNFMfHXT+rloL+7X7MeMBLpadk6mJ1M0t
         7AYQ==
X-Gm-Message-State: AOAM533KwuAXRBYvrdbHcMWmP/xK96OBlDrEjOsgPi0i5cFIzGNtDbt9
        JIvKlgk3n8o9hTLLA+pnd/BrnQ==
X-Google-Smtp-Source: ABdhPJzCnVJoIcOMHy2O1e/p0HqJQytfjloOj8iLPJOEr0XAEkGyHKVqSoEYbaZbGt7ihnRIC1VIFg==
X-Received: by 2002:ac8:7fd6:: with SMTP id b22mr4617392qtk.26.1636635527439;
        Thu, 11 Nov 2021 04:58:47 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s13sm1383495qki.23.2021.11.11.04.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 04:58:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ml9fB-008QPJ-LR; Thu, 11 Nov 2021 08:58:45 -0400
Date:   Thu, 11 Nov 2021 08:58:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
Message-ID: <20211111125845.GB876299@ziepe.ca>
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> Hi Jason, hi Leon,
> 
> We are seeing exactly the same error reported here:
> https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> 
> I suspect it's related to
> https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> 
> Do you have any idea, what goes wrong?

instrument ib_setup_port_attrs() until you find why it failed

Jason
