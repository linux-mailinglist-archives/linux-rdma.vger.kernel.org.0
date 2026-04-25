Return-Path: <linux-rdma+bounces-19551-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +uSSD1w97WmwhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19551-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 00:17:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2F468068
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 00:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B36443008E32
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03223115BC;
	Sat, 25 Apr 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sjcons.kr header.i=@sjcons.kr header.b="yuFmhWNp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hqmissioninboxes.com (hqmissioninboxes.com [212.56.37.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2C54723
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.56.37.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777155415; cv=none; b=h4kZJsW80y9V2e7X/KREFdDJSbiZpR1rZWnXHAEeCGGI/4dXkRC6pKENYIhZuaC6N4lxM/5QmHAXfIMgJkkGA67hJtWm/cGPcntIULV3aul9dm1CEI2361IXoCvFpiCdj7hkaPKYWUQkQiEP4GMh8cr5Jm27jdYqyWyTbAeCh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777155415; c=relaxed/simple;
	bh=X1KcEk65a1bQ2E/DlJCvEKiq6VJjJzP+QWrrtFP8Xf8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Aj0UwVWZzzXLG+FOtHLPkvxVDOtFBCUNJP5meSuEa/foVdAYD/xV+hUEe5pocPydELQ0CRam94LU5cytMhrwkIGGeURhtjyBJDuyUBNTyFflZH8s3G92e2ZqkEBs1HtmILhGouoTYPu6oLsK9QxkKOitzXTjkvWQVuIl8vkr0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sjcons.kr; spf=pass smtp.mailfrom=sjcons.kr; dkim=pass (1024-bit key) header.d=sjcons.kr header.i=@sjcons.kr header.b=yuFmhWNp; arc=none smtp.client-ip=212.56.37.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sjcons.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjcons.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sjcons.kr;
	s=mi-owGeXK; t=1777155075;
	bh=GUIjqwUfvV9p/9ASBGotl+T4fkYX1SiStV7Trj/Jcq4=;
	h=date:from:to:message-id:subject:mime-version:content-type:content-transfer-encoding;
	b=yuFmhWNp7rIarBpzEM4ZRTeLYjWcsVYsxeycIR3cvNfvDi71KaC+tfNJkAgUCb8Fawb0xAOR
	q+C/f4uX0DF0Ve+oscYysjFV85yZ0AD0XLldH2qfDCVZCcFuRVZn0htqmLlpcaDVF5pr9EO2
	E/M545B7/LLnCyWOnpulLWfVamQ=
X-MI-Unique: xVhe69eoGk4Xi328
Received: from api by mi.secureoutboxment.com with HTTP; Sat, 25 Apr 2026 22:11:15 +0000
Date: Sat, 25 Apr 2026 22:11:15 +0000
From: Support <info@sjcons.kr>
To: linux-rdma@vger.kernel.org
Message-ID: <e293b972-416f-4919-bae0-56d00ac4da2f@sjcons.kr>
Subject: Domain Renewal Notice
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="--==_mimepart_69ed3c03cebc3_137b2095312c0";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6BF2F468068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sjcons.kr,quarantine];
	R_PARTS_DIFFER(0.41)[70.6%];
	R_DKIM_ALLOW(-0.20)[sjcons.kr:s=mi-owGeXK];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	MANY_INVISIBLE_PARTS(0.05)[1];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_SPAM(0.00)[0.758];
	TAGGED_FROM(0.00)[bounces-19551-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[sjcons.kr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@sjcons.kr,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[notifications.googleapis.com:url]


----==_mimepart_69ed3c03cebc3_137b2095312c0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_69ed3c03ce62e_137b209531168"
Content-Transfer-Encoding: 7bit


----==_mimepart_69ed3c03ce62e_137b209531168
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit

Let's Keep Your Domain Active
    
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
            background-color: #f7f8fc;
            color: #2d3748;
            line-height: 1.6;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .header {
            background: linear-gradient(135deg, #0073aa 0%, #005a87 100%);
            padding: 48px 30px;
            text-align: center;
            color: white;
        }
        .header h1 {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }
        .header-subtext {
            font-size: 14px;
            opacity: 0.92;
        }
        .content {
            padding: 44px 30px;
        }
        .greeting {
            font-size: 16px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .message {
            font-size: 15px;
            line-height: 1.8;
            margin-bottom: 24px;
            color: #4a5568;
        }
        .feature-highlight {
            background: linear-gradient(135deg, #f0f6ff 0%, #e8f2ff 100%);
            border-radius: 8px;
            padding: 24px;
            margin: 28px 0;
            border: 1px solid #bfdbfe;
        }
        .feature-highlight .label {
            font-size: 12px;
            color: #0073aa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .feature-highlight .domain-name {
            font-size: 20px;
            font-weight: 700;
            color: #0073aa;
            word-break: break-all;
        }
        .cta-button {
            display: inline-block;
            background: linear-gradient(135deg, #0073aa 0%, #005a87 100%);
            color: white;
            padding: 16px 40px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            margin: 28px 0;
            transition: all 0.3s ease;
            box-shadow: 0 4px 14px rgba(0,115,170,0.2);
            width: 100%;
            text-align: center;
        }
        .cta-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,115,170,0.3);
        }
        .reassurance-section {
            background: #f9fafb;
            padding: 22px;
            border-radius: 8px;
            margin: 24px 0;
            border: 1px solid #e2e8f0;
        }
        .reassurance-section h3 {
            font-size: 14px;
            color: #0073aa;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .reassurance-section p {
            font-size: 14px;
            color: #4a5568;
            margin: 0;
        }
        .help-content {
            background: #f0f6ff;
            padding: 22px;
            border-radius: 8px;
            margin: 28px 0;
            border-left: 4px solid #0073aa;
        }
        .help-content p {
            font-size: 14px;
            margin-bottom: 8px;
            color: #1e3a8a;
        }
        .help-content a {
            color: #0073aa;
            font-weight: 600;
            text-decoration: none;
        }
        .help-content a:hover {
            text-decoration: underline;
        }
        .footer {
            background-color: #f7f8fc;
            padding: 28px 30px;
            border-top: 1px solid #e2e8f0;
            font-size: 12px;
            color: #718096;
            text-align: center;
        }
        .footer-logo {
            margin-bottom: 12px;
            font-weight: 700;
            color: #0073aa;
            font-size: 14px;
        }
    


    
        
            Let's Get Your Domain Back on Track
            A quick payment update is all we need
        
        
        
            Hi there,
            
            
                We tried to renew your domain, but our system encountered a hiccup with the payment. The good news? It's super easy to fix! Just update your payment details, and your domain vger.kernel.org will be good to go for another year.
            
            
            
                Domain Needing Renewal
                vger.kernel.org
            
            
            Update Your Payment Now
            
           
            
            
                Need a hand?
                Don't worry, we've got you covered. Head over to wordpress.com/support to find helpful resources, guides, and our friendly support team ready to assist you.
            
        
        
        
            WordPress.com
            60 29th St, San Francisco, CA 94110
----==_mimepart_69ed3c03ce62e_137b209531168
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html lang=3D"en">
<head>
    <meta charset=3D"UTF-8">
    <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-scal=
e=3D1.0">
    <title>Let's Keep Your Domain Active</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', '=
Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
            background-color: #f7f8fc;
            color: #2d3748;
            line-height: 1.6;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            background-color: #ffffff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .header {
            background: linear-gradient(135deg, #0073aa 0%, #005a87 100%)=
;
            padding: 48px 30px;
            text-align: center;
            color: white;
        }
        .header h1 {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }
        .header-subtext {
            font-size: 14px;
            opacity: 0.92;
        }
        .content {
            padding: 44px 30px;
        }
        .greeting {
            font-size: 16px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .message {
            font-size: 15px;
            line-height: 1.8;
            margin-bottom: 24px;
            color: #4a5568;
        }
        .feature-highlight {
            background: linear-gradient(135deg, #f0f6ff 0%, #e8f2ff 100%)=
;
            border-radius: 8px;
            padding: 24px;
            margin: 28px 0;
            border: 1px solid #bfdbfe;
        }
        .feature-highlight .label {
            font-size: 12px;
            color: #0073aa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .feature-highlight .domain-name {
            font-size: 20px;
            font-weight: 700;
            color: #0073aa;
            word-break: break-all;
        }
        .cta-button {
            display: inline-block;
            background: linear-gradient(135deg, #0073aa 0%, #005a87 100%)=
;
            color: white;
            padding: 16px 40px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            margin: 28px 0;
            transition: all 0.3s ease;
            box-shadow: 0 4px 14px rgba(0,115,170,0.2);
            width: 100%;
            text-align: center;
        }
        .cta-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,115,170,0.3);
        }
        .reassurance-section {
            background: #f9fafb;
            padding: 22px;
            border-radius: 8px;
            margin: 24px 0;
            border: 1px solid #e2e8f0;
        }
        .reassurance-section h3 {
            font-size: 14px;
            color: #0073aa;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .reassurance-section p {
            font-size: 14px;
            color: #4a5568;
            margin: 0;
        }
        .help-content {
            background: #f0f6ff;
            padding: 22px;
            border-radius: 8px;
            margin: 28px 0;
            border-left: 4px solid #0073aa;
        }
        .help-content p {
            font-size: 14px;
            margin-bottom: 8px;
            color: #1e3a8a;
        }
        .help-content a {
            color: #0073aa;
            font-weight: 600;
            text-decoration: none;
        }
        .help-content a:hover {
            text-decoration: underline;
        }
        .footer {
            background-color: #f7f8fc;
            padding: 28px 30px;
            border-top: 1px solid #e2e8f0;
            font-size: 12px;
            color: #718096;
            text-align: center;
        }
        .footer-logo {
            margin-bottom: 12px;
            font-weight: 700;
            color: #0073aa;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class=3D"container">
        <div class=3D"header">
            <h1>Let's Get Your Domain Back on Track</h1>
            <p class=3D"header-subtext">A quick payment update is all we =
need</p>
        </div>
        =

        <div class=3D"content">
            <p class=3D"greeting">Hi there,</p>
            =

            <p class=3D"message">
                We tried to renew your domain, but our system encountered=
 a hiccup with the payment. The good news? It's super easy to fix! Just u=
pdate your payment details, and your domain vger.kernel.org will be good =
to go for another year.
            </p>
            =

            <div class=3D"feature-highlight">
                <div class=3D"label">Domain Needing Renewal</div>
                <div class=3D"domain-name">vger.kernel.org</div>
            </div>
            =

            <a href=3D"https://notifications.googleapis.com/email/redirec=
t?t=3DAFG8qyVw_gjcIeE6iEVaoboKbCGaJ1xh-a3dScbWg313bVqED7lzu_8PkHik-wr-ldO=
uUfN4KAYcNouvWKd3ukrCpMEXtbCghRCeMxkmwEwccmEhS1T-S04uDk7VuLfIgGObW14Lj2vs=
gW07VMCcr6gNapHS07c_5Wd2-3GYL7fgF0TpTaSKfuzTNWUs5g9Soldq1-JrrpTu-UxvBWsuo=
FeIDPNKsaZOiiPzaLX1Rz1gf7XHP-zFBb-IwONPs_iDkTtJOshcTEtxui9OPhM4JU813bPH2M=
kerr_4-Zdv6epZ-c6LrocKtyc_8EEHMywfKKQ0ZyCDJfWZXidWBXlO2NCfSSqQ2LMYwU5tm22=
G8rUX0yGy3jiJcTuwoXXvflZ-SrE6nTrsS39yahol93DM5PT73YU--c8WY3a6B8YMBUlisEOu=
4Vr31bOkEp71ex-T_nnTH8fRG1gDiqNTy64EkFGu8eD2vMfqecNAaqkBZ8IiH7-uD8ShPSYbP=
tj_7U8UXSVSozb6Xw-Wrpy_2frQzS9koISOBRW5kTH14vhMbgsEbbdQPBd9Tvccy-LpnNJk-O=
5c8SqW8dpvDBskOveeoSm8LoI9sALIh88h1c94_z4mFwIdDRspwnUiq0EQVdAilH6H-gnPCEZ=
MuR9cBWE0wBWdyW0Nw8Uyq4jisZKEHMXjGN2CJs1gZ-L5SGFeuL9ure9NkPSs-0sWpiHbGBvs=
-xHfV5estevu_xtxCG49YCaxj1Xy0iOHER1vtNQ3hNHy6leSlZkXrYAbPnVK3mrvtAA0UaCdS=
Xf6ukf4BxajfTJcxqKtej9PHou3uIYbXE-AvsEYlxIhdMWRS6lcFcQYY754at_umu4w_J4gpC=
JGsmEDqWBYM5yGP0UUUmLG67aU6PprYUt3-zP1nlfxxr3D1vOEStj0mgmk8NBy-KBIeFA0xcp=
1Ek8mYVUPwJpQSE29FyI-DvyiK-eESrCV47oxYn3cTGMsoNMZH_EzXrhK4zEykdK46IdJEoO6=
a_Vk2fV7Al1mvGpPGmvJp-Ia-H3gKYXybdyzJzxktWhI1pk&r=3DeJzLKCkpKLbS189NLMrOS=
MzNzkwpTs7JzMtM1kvOz9XPNjQyNjE1M7dIBAAyLA3W&s=3DALHZ2r7MQ5y8kLFu7i59ijFbR=
Sb7" class=3D"cta-button">Update Your Payment Now</a>
            =

           =

            =

            <div class=3D"help-content">
                <p><strong>Need a hand?</strong></p>
                <p>Don't worry, we've got you covered. Head over to <a hr=
ef=3D"https://wordpress.com/support">wordpress.com/support</a> to find he=
lpful resources, guides, and our friendly support team ready to assist yo=
u.</p>
            </div>
        </div>
        =

        <div class=3D"footer">
            <div class=3D"footer-logo">WordPress.com</div>
            <p>60 29th St, San Francisco, CA 94110</p>
        </div>
    </div>
</body>
</html>

----==_mimepart_69ed3c03ce62e_137b209531168--

----==_mimepart_69ed3c03cebc3_137b2095312c0--

