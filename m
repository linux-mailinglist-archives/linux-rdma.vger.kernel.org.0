Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24371F158
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfEOLwW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 15 May 2019 07:52:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38536 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbfEOLUa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 07:20:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so3596165edl.5
        for <linux-rdma@vger.kernel.org>; Wed, 15 May 2019 04:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AhuTxT/lkfINsDjTLw18iMKanrsUxoyDzCmog8xfqus=;
        b=dgy3Isuy29TjWZdabZLJAHN6yRYXiY5XXr3XuOpca8lDVa5jJDyowV5aEkWReU6VrZ
         ei1ULRG1/Qjnde0796+xe2ws4XP5o7PEZycbq+/VG343ukQ6kDy+ZFUNCCo+bh30SaIW
         3k0JBc50PqyPEU0Hg6wYMLT8UMWcYR9WNZ3F90/ZXxOnvouacbl+KFgHNoH/s05IuCfv
         CHS9+WfFJrJ+AWH95UnrpCRk7vzTRnnlE76tbRliJJMZMsqvFyTI4S1tIAfqcQaWfnQZ
         77Vsz4w/zlSOZnv7qyB+PTdes/Sex/x2ZywqNqS/2fsDNXiu2WJNPtz6Si9DXh7W/K13
         1qHA==
X-Gm-Message-State: APjAAAVCsWk5MhwVfpERY8Glv2lkSbI55XK+Xmi1sQeyrHWPISAOq75i
        hTz1TFn3nJ+lG4af32QJotU5INcp
X-Google-Smtp-Source: APXvYqwppcElZOXdDJYYF1w0RzPkkcWTSuC63AFQYoQb9H1IMhteO8xph89xO87NWyjK4+Y0K2BG7A==
X-Received: by 2002:a17:906:a28d:: with SMTP id i13mr33164198ejz.148.1557919228349;
        Wed, 15 May 2019 04:20:28 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id x22sm695057edd.59.2019.05.15.04.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 04:20:27 -0700 (PDT)
Subject: Re: [RFC PATCH rdma-next] RDMA/srp: Don't cache device name as part
 of sysfs name
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190515095013.8141-1-leon@kernel.org>
 <20587db8-fd08-534b-56d6-98d261c41914@acm.org>
 <20190515110401.GK5225@mtr-leonro.mtl.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f684a7db-39b6-167c-423c-a5f0ddae9d7b@acm.org>
Date:   Wed, 15 May 2019 13:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515110401.GK5225@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/19 1:04 PM, Leon Romanovsky wrote:
> Any suggestions on what should be done in ib_srp to fix it?

Hi Leon,

How about adding an after_rename function pointer in struct ib_client,
making ib_device_rename() call that function and adding an
implementation of that callback in ib_srp that renames the SRP sysfs
attributes that contain the device name?

Thanks,

Bart.

