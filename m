Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E761ECF1D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgFCLze (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 07:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCLze (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 07:55:34 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682CC08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 04:55:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id r16so917561qvm.6
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L6DOEGFopsWDRRBi2ATbcjnn/6qt7fblZkSHMrN4xUk=;
        b=gWfIuecpWdWvblLEytU5YsYqlJckjKRTpJXOWBguY8PH/AK6cpiaY4dRTVwy4SlC4w
         oOTblJIqTBkw+V9oPUTze53E2GeemHDlMyrbrq2gDyUzlgqbMJ51qwIe13LDJt/0h9dK
         jnuQG+22CY/1Yf2HdUdZvYOpdpSEYXt1gozZsnnBiQbepfdAjvfAjZcOUuDrscuXroX4
         ST/eADk5pI9c3v6PQVKwIoqaO9nc7UrKBdQP5k3MG3wLRhmERyudDwySGyifJHBfqJWt
         CzDTt1Hd7/H8zsJBWkbBrFoZLZnh5rBI190tlwFvAR1WeCLUNgpg4TGp7SlgFRo0QtZp
         Olig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L6DOEGFopsWDRRBi2ATbcjnn/6qt7fblZkSHMrN4xUk=;
        b=MNSBCM3NN+jMScLjAMNBEGQzTTd9xaBaUsVo3/E0/Nu1PU9HdeWMGn9o3pAqdPlMwA
         YaLKzqZTqg/3uBc4Hw3JQQe/fmVAMF4pISRcOnTRzG8aEG4zQVM1maBiq4qB8NLpZ3Ru
         HICIn1Mga7FjQIMSEqDHSK3Kit7iPltvoWNgx6521K5mQ6DhZCdHskG5ArvKiZlag4HN
         /sJYrsBx4ais8SnxOj1EizrBD1F4jngYrffa4r8ulUdHDGJKy0a2osNxBTrxVeyOCAta
         CwTEodGcdA7BTN5iRsCHchxdxAhQisY90/3tcs15sKDio+tJx+Cd8mUvSv3YY7MEsE86
         jq2w==
X-Gm-Message-State: AOAM533a2galtbceqkqxeTZ9I5N9Q+cn3Dz2c9PJhz5mtt23GaqmEQdw
        0DcoE4YPz/2cJ9hoD0F1duLoEzdFBq8=
X-Google-Smtp-Source: ABdhPJzMxdvZgBJMAm6pwCXjk4d2XlaS3ez5wd2E2ITFoj3wa+EZVqjsHC9XAZQ5cHw6w3gBQqf6ew==
X-Received: by 2002:a0c:ed27:: with SMTP id u7mr6279917qvq.128.1591185333764;
        Wed, 03 Jun 2020 04:55:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h8sm1638274qto.0.2020.06.03.04.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 04:55:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgRzY-000itT-Gr; Wed, 03 Jun 2020 08:55:32 -0300
Date:   Wed, 3 Jun 2020 08:55:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: A question about cm_destroy_id()
Message-ID: <20200603115532.GG6578@ziepe.ca>
References: <8d6802a1-1706-0c01-78bf-0cdd3fea0881@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6802a1-1706-0c01-78bf-0cdd3fea0881@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 03, 2020 at 04:53:57PM +0800, Ka-Cheong Poon wrote:
> Suppose the cm_id state is IB_CM_REP_SENT when cm_destroy_id() is
> called.  Then it calls cm_send_rej_locked().  In cm_send_rej_locked(),
> it calls cm_enter_timewait() and the state is changed to IB_CM_TIMEWAIT.
> Now back to cm_destroy_id(), it breaks from the switch statement.  And
> the next call is WARN_ON(cm_id->state != IB_CM_IDLE).  The cm_id state
> is IB_CM_TIMEWAIT so it will log a warning.  Is the warning intended in
> this case?

Yes the warning is intended, most likely the break should be changed
to goto retest

Jason
