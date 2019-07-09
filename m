Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A08638C4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfGIPjI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 9 Jul 2019 11:39:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33734 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfGIPjI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 11:39:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so4695474pfq.0;
        Tue, 09 Jul 2019 08:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vhv+QzLlEpVv7HK4hE6vt/AhsNBtiAPjkQj7ht//l1E=;
        b=oowxynKi3iz0kJck73l/N7/XoZO2T/JTuG4wOujXQjNA1tLKAgyMV41BRjyChMmZ/8
         haQrL31h896dBszH/+Qeu/0wl51XGeN8ydY7sCkLEsA8rsSVzV61leyrDJBcJ33QrIa2
         GTNgzGCAKc8Lnjm/VdUw0tyQxE8ObUoJ+7jSH+3NuoHcI28d9A9YdbiJLJ1WOceIm1mb
         EuYgBs8e82je8awxUe9PIkJlzgppycxDUqij6HV9cBCHPQxriPr38yk8oHpoofg8T1Z5
         9wtPU067F9EzkmXCka99/f7r7HQVi3lx5TRZ5hjSCCWBZMQHMRVE/8CeyS4HBF2XsMBX
         vW4Q==
X-Gm-Message-State: APjAAAVdQ9bxkA+/oy/IjEx5YQAA4KHdHPE8u/1SSfuYo18MD0jdernq
        pE9hsbSUdMdM51CSvL/uVr4=
X-Google-Smtp-Source: APXvYqxMR7+jf2ZFl2+F56L8/KBnAO4b1VibdZP7NSJnCfanld2bX/P5rfxgysndHg7gEYvOe5w6Cw==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id d20mr853370pjw.28.1562686747859;
        Tue, 09 Jul 2019 08:39:07 -0700 (PDT)
Received: from [10.254.204.66] (50-242-106-94-static.hfc.comcastbusiness.net. [50.242.106.94])
        by smtp.gmail.com with ESMTPSA id j15sm22232513pfr.146.2019.07.09.08.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 08:39:06 -0700 (PDT)
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Greg KH <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, jgg@mellanox.com,
        dledford@redhat.com, Roman Pen <r.peniaev@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com> <20190709111737.GB6719@kroah.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4d1b1e56-dc66-a07d-8697-5b51c4c8f5c7@acm.org>
Date:   Tue, 9 Jul 2019 08:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190709111737.GB6719@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/9/19 4:17 AM, Greg KH wrote:
> So if these developers are willing to do the work to get something out
> of staging, and into the "real" part of the kernel, I will gladly take
> it.

Linus once famously said "given enough eyeballs, all bugs are shallow".
There are already two block-over-RDMA driver pairs upstream (NVMeOF and
SRP). Accepting the IBTRS and IBNBD drivers upstream would reduce the
number of users of the upstream block-over-RDMA drivers and hence would
fragment the block-over-RDMA driver user base further. Additionally, I'm
not yet convinced that the interesting parts of IBNBD cannot be
integrated into the existing upstream drivers. So it's not clear to me
whether taking the IBTRS and IBNBD drivers upstream would help the Linux
user community.

Bart.

